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
  let timelineWidth, timelineHeight;
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

  onMount(() => {
    const resizeObserver = new ResizeObserver(centerTimeline);
    resizeObserver.observe(timelineElement);
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
    if (zoomedMonthId === monthId) {
      await zoomOut();
    } else {
      live.pushEvent("pushMonth", {month: monthId}, () => {})
      await zoomIn(monthId);
    }
    isTransitioning = false;
  }
}

async function zoomIn(monthId) {
  zoomedMonthId = monthId;
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
    const scale = monthId === zoomedMonthId ? Math.min(timelineWidth, timelineHeight) / 200 : 0.1;
    const centerX = timelineWidth / 2;
    const centerY = timelineHeight / 2;
    const translateX = (centerX - monthId * MONTH_WIDTH) * (1 - scale) / scale;
    const translateY = centerY * (1 - scale) / scale;
    return `translate(${translateX}px, ${translateY}px) scale(${scale})`;
  }
</script>

<div>


  <div
    bind:this={timelineElement}
    on:mousedown={startDragging}
    on:mousemove={drag}
    on:mouseup={stopDragging}
    on:mouseleave={stopDragging}
    class="flex-2 overflow-x-auto cursor-grab active:cursor-grabbing select-none relative"
    bind:clientWidth={timelineWidth}
    bind:clientHeight={timelineHeight}
  >
    <svg width={TIMELINE_WIDTH} height={timelineHeight}>
      <g transform="translate(0, {(timelineHeight || 300) / 2})">
        {#each months as value, index}
          <g
            id="month-{index + 1}"
            style="transition: transform 0.5s ease-out; {getZoomTransform(index + 1)}"
            class="cursor-pointer"
          >
            <defs>
              <clipPath id="round-corner-{index + 1}">
                <rect x={index * MONTH_WIDTH} y="-100" width={MONTH_WIDTH} height="200" rx="5" ry="5"/>
              </clipPath>
            </defs>

            <rect
              x={index * MONTH_WIDTH}
              y="-200"
              width={MONTH_WIDTH}
              height="300"
              fill="transparent"

              stroke={zoomedMonthId === index + 1 ? "#006837" : "transparent"}
              stroke-width="1"
              on:mouseenter={() => handleMonth(index + 1)}
              on:touchstart={() => handleMonth(index + 1)}
            />
            <line
              x1={index * MONTH_WIDTH + MONTH_WIDTH / 2}
              y2={zoomedMonthId === index + 1 ? 50 : 10}
              x2={index * MONTH_WIDTH + MONTH_WIDTH / 2}
              y1={zoomedMonthId === index + 1 ? -100 : -40}
              stroke="#006837"
              stroke-width={zoomedMonthId === index + 1 ? "50" : "5"}
              class="pointer-events-none hover:stroke-green-300 duration-200"
            />
          </g>
        {/each}
      </g>
    </svg>
  </div>
</div>
