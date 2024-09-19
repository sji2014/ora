<script>
  import { onMount, tick } from 'svelte';
  import { tweened } from 'svelte/motion';
  import { cubicOut, quintOut } from 'svelte/easing';
  import { fade, fly, scale } from 'svelte/transition';

  // Constants
  const TOTAL_MONTHS = 48; // 4 years * 12 months
  const MONTH_WIDTH = 50;
  const TIMELINE_WIDTH = TOTAL_MONTHS * MONTH_WIDTH;
  const ANIMATION_DURATION = 1000;
  const ANIMATION_INTERVAL = 100;

  // State variables
  let timelineElement;
  let isDragging = false;
  let dragStartX;
  let initialScrollLeft;
  let zoomedMonthId = null;
  let isTransitioning = false;
  export let id;
  export let timelineWidth, timelineHeight;
  export let live

  // Generate initial month data
  let months = Array.from({ length: TOTAL_MONTHS }, (_, index) => ({
    id: index + 1,
    height: Math.floor(Math.random() * 75) + 25,
  }));

  let zoomScale = tweened(5, {
    duration: 300,
    easing: quintOut
  });

  let hoverScale = tweened(1, {
    duration: 200,
    easing: cubicOut
  });

  const debounce = (func, delay) => {
    let timeout;
    return function(...args) {
        const context = this;
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(context, args), delay);
    };
};
  
  onMount(() => {
    const resizeObserver = new ResizeObserver(centerTimeline);
    resizeObserver.observe(timelineElement);
    live.handleEvent("pullMonth", (time) => {
      handleMonth(time.index)
      
      });
    return () => resizeObserver.disconnect();
    

    
  });

  function centerTimeline() {
    if (timelineElement) {
      timelineElement.scrollLeft = TIMELINE_WIDTH / 2 - timelineElement.clientWidth / 2;
    }
  }
  

  async function handleMonth(monthId) {
    if (!isDragging && !isTransitioning) {
      isTransitioning = true;
      if (zoomedMonthId !== monthId) {
        zoomedMonthId = monthId
        live.pushEvent("pushMonth", {month: monthId+1}, () => {})
        await zoomIn(monthId);
      }
      isTransitioning = false;
    }
  }

  async function handleMonthTouch(monthId) {
    if (!isDragging && !isTransitioning) {
      isTransitioning = true;
      if (zoomedMonthId !== monthId) {
        zoomedMonthId = monthId
        live.pushEvent("pushMonth", {month: monthId+1}, () => {})
        await zoomIn(monthId);
      } else {
        live.pushEvent("pushMonth", {month: null}, () => {})
        await zoomOut();
      }
      isTransitioning = false;
    }
  }
  
async function zoomIn(monthId) {
  await tick();
  zoomScale.set(2, {
    duration: 300,
    easing: quintOut
  });
  scrollToMonth(monthId);
}

async function zoomOut() {
  zoomedMonthId = null;
  zoomScale.set(1, {
    duration: 300,
    easing: quintOut
  });
  await tick();
}

  function scrollToMonth(monthId) {
    const targetElement = document.getElementById(`month-${monthId}`);
  if (targetElement) {
    const rect = targetElement.getBoundingClientRect();
    
    // Calculate the target scroll position to center the month
    const targetPosition = monthId * MONTH_WIDTH - (timelineWidth / 2) + (MONTH_WIDTH / 2);
    
    // Ensure the scroll position is within bounds
    const scrollX = Math.max(0, Math.min(targetPosition, (TOTAL_MONTHS * MONTH_WIDTH) - timelineWidth));
    
    // Scroll to the calculated position
    timelineElement.scrollTo({
      left: scrollX,
      behavior: 'smooth'
    });
  }
}

  function startDragging(event) {
    if (!zoomedMonthId) {
      isDragging = true;
      dragStartX = event.pageX - timelineElement.offsetLeft;
      initialScrollLeft = timelineElement.scrollLeft;
    }
  }

  function stopDragging() {
    isDragging = false;
  }

  function drag(event) {
    if (!isDragging || zoomedMonthId) return;
    event.preventDefault();
    const dragDistance = (event.pageX - timelineElement.offsetLeft - dragStartX) * 2;
    timelineElement.scrollLeft = initialScrollLeft - dragDistance;
  }

  function getZoomTransform(monthId) {
    if (zoomedMonthId === null) return 'scale(1)';
    //const scale = monthId === zoomedMonthId ? Math.min(timelineWidth, timelineHeight) / 200 : 0.1;
    const centerX = timelineWidth / 2;
    const centerY = timelineHeight / 2;
    const translateX = (centerX - monthId * MONTH_WIDTH) * (1 - scale) / scale;
    const translateY = centerY * (1 - scale) / scale;
    return `scale(${scale})`;
  }
</script>

  <div
    id={id}
    bind:this={timelineElement}
    on:mousedown={startDragging}
    on:mousemove={drag}
    on:mouseup={stopDragging}
    on:mouseleave={stopDragging}
    class="relative bottom-0 flex-none overflow-x-auto cursor-grab active:cursor-grabbing select-none no-scrollbar"
    bind:clientWidth={timelineWidth}
    bind:clientHeight={timelineHeight}
  >
    <svg width={TIMELINE_WIDTH} height={timelineHeight}>
      <g transform="translate(0, {(timelineHeight || 300) / 2})">
        {#each months as value, index}
          <g
            id="month-{index + 1}"
            
            class="cursor-pointer"
          >

            <rect
              x={index * MONTH_WIDTH + MONTH_WIDTH/4}
              y={zoomedMonthId === index? "-90" : "-70"}
              width={zoomedMonthId === index ? MONTH_WIDTH/3 : MONTH_WIDTH/4}
              height={zoomedMonthId === index ? "90" : "50"}
              fill="#006837"
              rx="8"
              ry="8"

              stroke={zoomedMonthId === index  ? "#006837" : "transparent"}
              stroke-width="1"
            />

            // splash for svg is rendered on top if defined after prev rect

            <rect
              x={(index) * MONTH_WIDTH}
              y="-100"
              width={MONTH_WIDTH}
              height="200"
              fill="transparent"
              on:mouseenter={() => handleMonth(index)}
              on:touchstart={() => handleMonthTouch(index)}
            />

          </g>
        {/each}
      </g>
      
    </svg>
  </div>
  
