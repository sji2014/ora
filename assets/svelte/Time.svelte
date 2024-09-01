<script>
  import { onMount, tick } from 'svelte';
  import { tweened } from 'svelte/motion';
  import { cubicOut, quintOut} from 'svelte/easing';
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

    const scale = monthId === zoomedMonthId
      ? Math.min(timelineWidth, timelineHeight) / 200
      : 0.1;

    const centerX = timelineWidth / 2;
    const centerY = timelineHeight / 2;
    const translateX = (centerX - monthId * MONTH_WIDTH) * (1 - scale) / scale;
    const translateY = centerY * (1 - scale) / scale;

    return `translate(${translateX}px, ${translateY}px) scale(${scale})`;
  }
</script>

<div class="font-mono text-center bg-black text-green-500 min-h-screen flex flex-col p-4">
  <h1 class="text-4xl font-bold my-8" class:invisible={zoomedMonthId !== null}>
    timeline bois
  </h1>

  <div
    bind:this={timelineElement}
    on:mousedown={startDragging}
    on:mousemove={drag}
    on:mouseup={stopDragging}
    on:mouseleave={stopDragging}
    class="flex-1 overflow-x-auto cursor-grab active:cursor-grabbing select-none relative"
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
            <rect
              x={index * MONTH_WIDTH}
              y="-100"
              width={MONTH_WIDTH}
              height="200"
              fill="transparent"
              stroke={zoomedMonthId === index + 1 ? "#00ff00" : "transparent"}
              stroke-width="1"
              on:mouseenter={() => handleMonth(index + 1)}
            />
            <line
              x1={index * MONTH_WIDTH + MONTH_WIDTH / 2}
              y2={zoomedMonthId === index + 1 ? 100 : 10}
              x2={index * MONTH_WIDTH + MONTH_WIDTH / 2}
              y1={zoomedMonthId === index + 1 ? -100 : -100}
              stroke="#00ff00"
              stroke-width={zoomedMonthId === index + 1 ? "50" : "5"}
              class="pointer-events-none hover:stroke-green-300 duration-200"
            />
            {#if zoomedMonthId === index + 1}
              <foreignObject x={index * MONTH_WIDTH - 250} y="-600" width="500" height="500">
                <div
                  in:fade={{ duration: 300, delay: 200 }}
                  out:fade={{ duration: 200 }}
                  class="w-full h-full bg-green-900 bg-opacity-20 rounded-lg shadow-inner flex items-center justify-center">
    <button
      on:click={zoomOut}
      class="fixed right-0 top-2/7 text-white hover:text-green-300"
    >
      &times;
    </button>
                  <div in:fly={{ y: 20, duration: 300, delay: 300 }} class="text-4xl">
                    Month {index + 1}
                    <div class="mt-4 text-xs">
                      alamak Gallery here
                    </div>
                  </div>
                </div>
              </foreignObject>
            {/if}
          </g>
        {/each}
      </g>
    </svg>
  </div>
</div>
