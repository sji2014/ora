<script>
    let indicator;
    let items;
    let activeIndex = 0;

    function handleIndicator(index) {
        activeIndex = index;
        items.forEach((item, i) => {
            if (i === index) {
                item.classList.remove('text-gray-400');
                item.classList.add('text-teal-400');
            } else {
                item.classList.remove('text-teal-400');
                item.classList.add('text-gray-400');
            }
        });

        indicator.style.width = `${items[index].offsetWidth}px`;
        indicator.style.left = `${items[index].offsetLeft}px`;
    }

    $: {
        if (items) {
            handleIndicator(activeIndex);
        }
    }
</script>

<nav class="relative w-96 flex justify-between p-4 bg-transparent border border-gray-700 rounded-full overflow-hidden">
    <a href="#" class="nav-item relative flex flex-col items-center justify-center text-gray-400 hover:text-teal-400 transition duration-300">
        <span class="text-xs font-semibold">2011</span>
    </a>
    <a href="#" class="nav-item relative flex flex-col items-center justify-center text-gray-400 hover:text-teal-400 transition duration-300">
        <span class="text-xs font-semibold">2012</span>
    </a>
    <a href="#" class="nav-item relative flex flex-col items-center justify-center text-gray-400 hover:text-teal-400 transition duration-300">
        <i class='bx bx-plus text-2xl'></i>
    </a>
    <a href="#" class="nav-item relative flex flex-col items-center justify-center text-gray-400 hover:text-teal-400 transition duration-300">
        <span class="text-xs font-semibold">2013</span>
    </a>
    <a href="#" class="nav-item relative flex flex-col items-center justify-center text-gray-400 hover:text-teal-400 transition duration-300">
        <span class="text-xs font-semibold">2014</span>
    </a>

    <div class="nav-indicator-wrapper absolute top-0 left-0 flex justify-center">
        <span class="nav-indicator block w-8 h-1 bg-teal-400 rounded-full"></span>
    </div>
</nav>


<style>
    .nav-indicator {
        transition: left 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.175);
    }
</style>
