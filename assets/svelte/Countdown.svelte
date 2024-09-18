<script>
  export let dateTime;
  let defaultTime = new Date("Dec 7, 2024 18:00:00").getTime();

  function pad(number) {
    return number < 10 ? `0${number}` : number;
  }

  function getTimeRemaining() {
    let distance = (dateTime * 1000 || defaultTime) - Date.now();
    if (distance < 0) {
      return {
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
        expired: true
      };
    }

    return {
      days: Math.floor(distance / (1000 * 60 * 60 * 24)),
      hours: pad(Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))),
      minutes: pad(Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))),
      seconds: pad(Math.floor((distance % (1000 * 60)) / 1000)),
      expired: false
    };
  }

  let { days, hours, minutes, seconds, expired } = getTimeRemaining();

  setInterval(() => {
    ({ days, hours, minutes, seconds, expired } = getTimeRemaining());
  }, 1000);

</script>
  <div class="flex justify-center space-x-4">
    <div class="flex flex-col items-center">
      <div class="text-4xl font-bold">{days}</div>
      <div class="text-gray-400">Days</div>
    </div>
    <div class="flex flex-col items-center">
      <div class="text-4xl font-bold">{hours}</div>
      <div class="text-gray-400">Hours</div>
    </div>
    <div class="flex flex-col items-center">
      <div class="text-4xl font-bold">{minutes}</div>
      <div class="text-gray-400">Minutes</div>
    </div>
    <div class="flex flex-col items-center">
      <div class="text-4xl font-bold">{seconds}</div>
      <div class="text-gray-400">Seconds</div>
    </div>
  </div>
