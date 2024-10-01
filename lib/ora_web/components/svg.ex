defmodule OraWeb.SVG do
  use Phoenix.Component

  @doc """
  Renders a ticket

  ## Examples

      <.ticket/>
  """
  attr :class, :string, default: nil
  attr :name, :string, default: nil
  attr :ticketId, :string, default: nil
  attr :datetime, :string, default: nil
  attr :rest, :global

  def ticket(assigns) do
    ~H"""
    <svg
      version="1.1"
      class={[@class]}
      viewBox="-100 -50 845.8666 366.07997"
      xmlns="http://www.w3.org/2000/svg"
      xmlns:svg="http://www.w3.org/2000/svg"
      {@rest}
    >
      <defs id="defs9">
        <style id="style1">
          .cls-1{clip-path:url(#clippath-11);}.cls-2{font-family:ArialMT, Arial;}.cls-2,.cls-3,.cls-4,.cls-5,.cls-6,.cls-7{isolation:isolate;}.cls-2,.cls-3,.cls-8,.cls-7{fill:#006837;}.cls-2,.cls-3,.cls-6,.cls-7{font-size:51.35px;}.cls-9{fill:#000;}.cls-9,.cls-10,.cls-8,.cls-11{stroke-width:0px;}.cls-3{font-family:TimesNewRomanPS-BoldMT, 'Times New Roman';font-weight:700;}.cls-12{clip-path:url(#clippath-2);}.cls-13{clip-path:url(#clippath-13);}.cls-14{clip-path:url(#clippath-15);}.cls-15{clip-path:url(#clippath-6);}.cls-5{fill:#333;font-family:CenturySchoolbook, 'Century Schoolbook';font-size:34.23px;}.cls-10,.cls-6,.cls-16{fill:none;}.cls-17{clip-path:url(#clippath-7);}.cls-18{clip-path:url(#clippath-1);}.cls-19{clip-path:url(#clippath-4);}.cls-20{font-size:22px;letter-spacing:.1em;}.cls-20,.cls-6,.cls-7{font-family:BakbakOne-Regular, 'Bakbak One';}.cls-20,.cls-11{fill:#fff;}.cls-21{clip-path:url(#clippath-12);}.cls-22{clip-path:url(#clippath-9);}.cls-6{stroke:#006837;stroke-miterlimit:10;}.cls-6,.cls-7{letter-spacing:.07em;}.cls-23{clip-path:url(#clippath);}.cls-24{clip-path:url(#clippath-3);}.cls-25{clip-path:url(#clippath-8);}.cls-26{clip-path:url(#clippath-14);}.cls-27{clip-path:url(#clippath-5);}.cls-16{stroke:#fff;stroke-width:2px;}.cls-28{clip-path:url(#clippath-10);}
        </style>
        <clipPath id="clippath">
          <rect class="cls-10" x="270.69" y="20.639999" width="533.34003" height="264" id="rect1" />
        </clipPath>
        <clipPath id="clippath-1">
          <rect class="cls-10" x="282.92999" y="228.32001" width="103.76" height="30.93" id="rect2" />
        </clipPath>
        <clipPath id="clippath-2">
          <path
            class="cls-10"
            d="m 298.37,228.32 h 72.79 c 4.1,0 8.03,1.63 10.92,4.53 2.9,2.9 4.53,6.82 4.53,10.92 0,4.1 -1.63,8.02 -4.53,10.92 -2.9,2.9 -6.82,4.52 -10.92,4.52 h -72.79 c -4.09,0 -8.03,-1.63 -10.92,-4.52 -2.9,-2.9 -4.52,-6.83 -4.52,-10.92 0,-4.09 1.63,-8.03 4.52,-10.92 2.89,-2.89 6.83,-4.53 10.92,-4.53 z"
            id="path2"
          />
        </clipPath>
        <clipPath id="clippath-3">
          <rect class="cls-10" x="511.79999" y="228.32001" width="115.99" height="30.93" id="rect3" />
        </clipPath>
        <clipPath id="clippath-4">
          <path
            class="cls-10"
            d="m 527.24,228.32 h 84.67 c 4.09,0 8.03,1.63 10.92,4.53 2.89,2.9 4.52,6.82 4.52,10.92 0,4.1 -1.63,8.02 -4.52,10.92 -2.9,2.9 -6.83,4.52 -10.92,4.52 h -84.67 c -4.1,0 -8.03,-1.63 -10.92,-4.52 -2.9,-2.9 -4.53,-6.83 -4.53,-10.92 0,-4.09 1.63,-8.03 4.53,-10.92 2.9,-2.89 6.82,-4.53 10.92,-4.53 z"
            id="path3"
          />
        </clipPath>
        <clipPath id="clippath-5">
          <rect class="cls-10" x="397.28" y="228.32001" width="103.92" height="30.93" id="rect4" />
        </clipPath>
        <clipPath id="clippath-6">
          <path
            class="cls-10"
            d="m 412.73,228.32 h 72.79 c 4.1,0 8.03,1.63 10.92,4.53 2.89,2.9 4.53,6.82 4.53,10.92 0,4.1 -1.63,8.02 -4.53,10.92 -2.9,2.9 -6.82,4.52 -10.92,4.52 h -72.79 c -4.1,0 -8.03,-1.63 -10.92,-4.52 -2.9,-2.9 -4.53,-6.83 -4.53,-10.92 0,-4.09 1.63,-8.03 4.53,-10.92 2.9,-2.89 6.82,-4.53 10.92,-4.53 z"
            id="path4"
          />
        </clipPath>
        <clipPath id="clippath-7">
          <rect class="cls-10" x="631.58002" y="20.639999" width="31.540001" height="10.9" id="rect5" />
        </clipPath>
        <clipPath id="clippath-8">
          <circle class="cls-10" cx="647.34998" cy="15.77" r="15.77" id="circle5" />
        </clipPath>
        <clipPath id="clippath-9">
          <rect class="cls-10" x="786.58002" y="20.639999" width="17.450001" height="10.9" id="rect6" />
        </clipPath>
        <clipPath id="clippath-10">
          <path
            class="cls-10"
            d="m 802.35,0 c -8.71,0 -15.77,7.06 -15.77,15.77 0,8.71 7.06,15.77 15.77,15.77 8.71,0 15.78,-7.06 15.78,-15.77 C 818.13,7.06 811.07,0 802.35,0 Z"
            id="path6"
          />
        </clipPath>
        <clipPath id="clippath-15">
          <rect class="cls-10" x="669.84998" y="102.78" width="116.84" height="117" id="rect9" />
        </clipPath>
      </defs>
      <g id="g148" transform="translate(17.323731,7.0815848)">
        <g
          class="cls-23"
          clip-path="url(#clippath)"
          id="g9"
          transform="matrix(1.018272,0,0,1,-162.73934,-18.457085)"
        >
          <path class="cls-8" d="M 270.69,1.2 H 831.51 V 300.3 H 270.69 Z" id="path9" />
        </g>
        <g
          class="cls-18"
          clip-path="url(#clippath-1)"
          id="g11"
          transform="translate(-148.04813,-18.457085)"
        >
          <g class="cls-12" clip-path="url(#clippath-2)" id="g10">
            <path
              class="cls-16"
              d="m 298.37,228.32 h 72.79 c 4.1,0 8.03,1.63 10.92,4.53 2.9,2.9 4.53,6.82 4.53,10.92 0,4.1 -1.62,8.02 -4.53,10.92 -2.9,2.9 -6.82,4.52 -10.92,4.52 h -72.79 c -4.09,0 -8.03,-1.62 -10.92,-4.52 -2.9,-2.9 -4.52,-6.83 -4.52,-10.92 0,-4.09 1.62,-8.03 4.52,-10.92 2.9,-2.9 6.83,-4.53 10.92,-4.53 z"
              id="path10"
            />
          </g>
        </g>
        <g
          class="cls-24"
          clip-path="url(#clippath-3)"
          id="g13"
          transform="translate(-148.04813,-18.457085)"
        >
          <g class="cls-19" clip-path="url(#clippath-4)" id="g12">
            <path
              class="cls-16"
              d="m 527.24,228.32 h 84.67 c 4.09,0 8.03,1.63 10.92,4.53 2.9,2.9 4.52,6.82 4.52,10.92 0,4.1 -1.62,8.02 -4.52,10.92 -2.9,2.9 -6.83,4.52 -10.92,4.52 h -84.67 c -4.1,0 -8.03,-1.62 -10.92,-4.52 -2.9,-2.9 -4.53,-6.83 -4.53,-10.92 0,-4.09 1.63,-8.03 4.53,-10.92 2.9,-2.9 6.82,-4.53 10.92,-4.53 z"
              id="path11"
            />
          </g>
        </g>
        <g
          class="cls-27"
          clip-path="url(#clippath-5)"
          id="g15"
          transform="translate(-148.04813,-18.457085)"
        >
          <g class="cls-15" clip-path="url(#clippath-6)" id="g14">
            <path
              class="cls-16"
              d="m 412.73,228.32 h 72.79 c 4.1,0 8.03,1.63 10.92,4.53 2.9,2.9 4.53,6.82 4.53,10.92 0,4.1 -1.63,8.02 -4.53,10.92 -2.9,2.9 -6.82,4.52 -10.92,4.52 h -72.79 c -4.1,0 -8.03,-1.62 -10.92,-4.52 -2.9,-2.9 -4.53,-6.83 -4.53,-10.92 0,-4.09 1.63,-8.03 4.53,-10.92 2.9,-2.9 6.82,-4.53 10.92,-4.53 z"
              id="path13"
            />
          </g>
        </g>
        <path
          class="cls-9"
          d="m 497.79187,264.22291 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.259995 h 2 v 5.259995 m -2,-7.019995 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.01 v -5.26 h 2 v 5.26 m -2,-7.02 v -5.26 h 2 v 5.26 m -2,-7.02 V 6.3329149 h 2 v 5.2600001 m -2,-7.0200001 V 0.79291492 h 2 V 4.5729149"
          id="path15"
          style="fill:#ffffff"
        />
        <g
          class="cls-17"
          clip-path="url(#clippath-7)"
          id="g17"
          style="fill:#ffffff"
          transform="matrix(1,0,0,1.0240797,-148.47638,-21.137004)"
        >
          <g class="cls-25" clip-path="url(#clippath-8)" id="g16" style="fill:#ffffff">
            <path
              class="cls-9"
              d="m 631.58,0 h 31.54 v 31.54 h -31.54 z"
              id="path16"
              style="fill:#ffffff"
            />
          </g>
        </g>
        <g
          class="cls-17"
          clip-path="url(#clippath-7)"
          id="g17-5"
          style="fill:#ffffff"
          transform="matrix(-1,0,0,-1.0240797,1145.9813,290.23732)"
        >
          <g class="cls-25" clip-path="url(#clippath-8)" id="g16-6" style="fill:#ffffff">
            <path
              class="cls-9"
              d="m 631.58,0 h 31.54 v 31.54 h -31.54 z"
              id="path16-2"
              style="fill:#ffffff;stroke-width:0px"
            />
          </g>
        </g>
        <g
          class="cls-22"
          clip-path="url(#clippath-9)"
          id="g19"
          style="fill:#ffffff"
          transform="matrix(2.2413172,0,0,2.0200202,-1126.5055,-48.498402)"
        >
          <g class="cls-28" clip-path="url(#clippath-10)" id="g18" style="fill:#ffffff">
            <path
              class="cls-9"
              d="m 786.58,0 h 31.55 v 31.54 h -31.55 z"
              id="path17"
              style="fill:#ffffff"
            />
          </g>
        </g>
        <path
          class="cls-11"
          d="m 596.27187,94.342915 v 32.229995 h 32.22 V 94.342915 Z m 26.86,10.739995 v 5.38 h -5.38 v 5.37 h 5.38 v 5.37 h -21.49 v -10.74 h 5.38 v -5.38 h -5.38 v -5.369995 h 5.38 v 5.369995 h 5.37 v -5.369995 h 10.74 z"
          id="path23"
        />
        <path class="cls-11" d="m 612.38187,105.08291 h 5.37 v 5.38 h -5.37 z" id="path24" />
        <path
          class="cls-11"
          d="m 585.53187,115.82291 v 5.37 h 5.38 V 99.712915 h -16.11 v 5.369995 h 5.37 v 5.38 h 5.37 v 5.37 z"
          id="path25"
        />
        <path class="cls-11" d="m 607.01187,110.45291 h 5.37 v 5.37 h -5.37 z" id="path26" />
        <path
          class="cls-11"
          d="M 564.04187,115.82291 V 94.342915 h -32.22 v 32.229995 h 32.22 v -10.74 z m -5.37,-16.109995 v 10.739995 h -5.37 V 99.712915 Z m -21.48,0 h 5.38 v 5.369995 h -5.38 z m 10.74,21.479995 v -5.38 h -5.37 v 5.38 h -5.38 v -5.38 h 5.38 v -5.37 h 5.37 v 5.37 h 10.74 v 5.38 z"
          id="path27"
        />
        <path
          class="cls-11"
          d="m 574.79187,115.82291 h 5.37 v -5.37 h -10.74 v 10.74 h 5.38 v -5.37 z"
          id="path28"
        />
        <path
          class="cls-11"
          d="m 564.04187,131.93291 v 26.86 h 32.22 v -32.23 h -32.22 z m 21.49,0 v 5.38 h 5.38 v 16.11 h -16.11 v -10.74 h 5.37 v -5.37 h -10.74 v -5.38 h 16.11 z"
          id="path29"
        />
        <path
          class="cls-11"
          d="m 558.67187,137.31291 v -5.38 h -16.11 v 5.38 h -5.38 v 16.11 h 5.38 v -10.74 h 5.37 v -5.37 z"
          id="path30"
        />
        <path class="cls-11" d="m 607.01187,131.93291 h 16.11 v 5.38 h -16.11 z" id="path31" />
        <path class="cls-11" d="m 601.64187,137.31291 h 5.37 v 5.37 h -5.37 z" id="path32" />
        <path class="cls-11" d="m 547.93187,142.68291 h 5.37 v 5.37 h -5.37 z" id="path33" />
        <path class="cls-11" d="m 580.16187,142.68291 h 5.37 v 5.37 h -5.37 z" id="path34" />
        <path
          class="cls-11"
          d="m 612.38187,142.68291 v 5.37 h -10.74 v 5.37 h 21.48 v -5.37 h -5.38 v -5.37 h -5.37 z"
          id="path35"
        />
        <path class="cls-11" d="m 553.30187,148.05291 h 5.38 v 5.37 h -5.38 z" id="path36" />
        <path
          class="cls-11"
          d="m 531.82187,164.16291 v 26.85 h 32.22 v -32.22 h -32.22 z m 21.48,21.48 h -5.37 v -5.37 h -5.37 v 5.37 h -5.38 v -5.37 h 5.38 v -5.37 h 5.37 v 5.37 h 5.37 z m 0,-21.48 v 5.37 h 5.38 v 5.38 h -5.38 v -5.38 h -5.37 v -5.37 z m -10.74,0 v 5.37 h -5.38 v -5.37 z"
          id="path37"
        />
        <path
          class="cls-11"
          d="m 585.53187,164.16291 h -10.74 v 5.37 h -5.38 v 16.11 h 5.38 v -10.74 h 5.37 v 10.74 h 5.37 v -10.74 h 5.38 v -5.37 h -5.38 z"
          id="path38"
        />
        <path
          class="cls-11"
          d="m 596.27187,169.53291 v 21.48 h 32.22 v -32.23 h -32.22 v 10.74 z m 10.74,-5.37 v 10.74 h 16.11 v 10.74 h -21.49 v -21.48 z"
          id="path39"
        />
        <g
          class="cls-14"
          clip-path="url(#clippath-15)"
          id="g40"
          transform="translate(-148.04813,-18.457085)"
        >
          <path
            class="cls-11"
            d="M 786.57,219.5 H 669.84 V 102.77 h 116.73 z m -114.46,-2.27 h 112.2 V 105.04 h -112.2 z"
            id="path40"
          />
        </g>
        <g id="g5" class="cls-4" transform="rotate(-90,54.869684,207.12971)">
          <g id="text4" class="cls-4">
            <text class="cls-3" transform="translate(14.23,190.75)" id="text130">
              <tspan x="0" y="0" id="tspan130">BACK</tspan>
            </text>
          </g>
          <g id="text5" class="cls-4">
            <text class="cls-3" transform="translate(0,233.54)" id="text131">
              <tspan x="0" y="0" id="tspan131">HOME</tspan>
            </text>
          </g>
        </g>
        <g id="g145" transform="translate(-148.04813,-18.113556)">
          <rect
            id="rect135"
            class="cls-8"
            x="-105.87647"
            y="148.04813"
            width="85.580002"
            height="84.150002"
            transform="rotate(-90)"
          />
          <path
            id="path135"
            class="cls-11"
            d="m 227.81812,36.646465 c -0.03,0.29 -0.21,0.46 -0.33,0.64 -5.55,8.54 -11.11,17.09 -16.67,25.629998 -0.29,0.43 -0.29,0.74 0,1.18 5.61,8.59 11.2,17.2 16.79,25.8 0.09,0.14 0.23,0.26 0.21,0.48 -0.3,0.03 -0.56,-0.09 -0.83,-0.17 -9.29,-2.67 -18.57,-5.33 -27.86,-8.03 -0.63,-0.19 -0.98,-0.07 -1.38,0.43 -4.76,5.96 -9.54,11.899998 -14.32,17.839997 -1.06,1.31 -2.11,2.62 -3.17,3.92 -0.11,0.14 -0.21,0.39 -0.41,0.31 -0.23,-0.07 -0.14,-0.31 -0.14,-0.5 0,-8.829999 0.01,-17.669997 0.03,-26.499997 0,-0.73 0,-1.45 0.03,-2.2 0.01,-0.47 -0.2,-0.71 -0.61,-0.87 -3.82,-1.45 -7.64,-2.92 -11.47,-4.39 -5.53,-2.13 -11.05,-4.26 -16.59,-6.4 -0.06,-0.03 -0.13,-0.04 -0.19,-0.07 -0.14,-0.07 -0.4,-0.07 -0.41,-0.24 0,-0.23 0.27,-0.23 0.43,-0.29 l 18.78,-7.359998 c 3.14,-1.23 6.26,-2.45 9.4,-3.67 0.43,-0.17 0.63,-0.4 0.6,-0.86 -0.03,-0.54 0,-1.08 0,-1.63 v -26.56 c 0,-0.29 -0.17,-0.71 0.14,-0.83 0.26,-0.09 0.41,0.34 0.58,0.56 5.79,7.6 11.6,15.22 17.37,22.83 0.34,0.46 0.64,0.54 1.18,0.37 9.37,-3.12 18.76,-6.23 28.14,-9.34 0.21,-0.07 0.43,-0.2 0.68,-0.14 v 0.03 z m -46.18,-8.26 c -0.17,0.31 -0.16,0.61 -0.16,0.91 v 24.3 c 0,0.61 0.2,1.04 0.67,1.44 3.04,2.57 6.05,5.149998 9.07,7.739998 0.17,0.14 0.46,0.29 0.34,0.57 -0.1,0.29 -0.4,0.2 -0.63,0.2 h -33.79 c -0.3,0 -0.78,-0.13 -0.84,0.23 -0.06,0.31 0.44,0.36 0.7,0.46 7.69,2.92 15.38,5.83 23.05,8.76 0.58,0.21 1.04,0.14 1.54,-0.27 3.07,-2.65 6.16,-5.28 9.26,-7.92 0.23,-0.2 0.48,-0.58 0.81,-0.39 0.37,0.23 0.09,0.63 0,0.93 -1.81,6.19 -3.64,12.38 -5.45,18.58 -1.35,4.59 -2.7,9.19 -4.04,13.789998 -0.09,0.309999 -0.33,0.739999 0.03,0.929999 0.36,0.2 0.51,-0.29 0.7,-0.51 4.69,-5.979997 9.37,-11.949997 14.06,-17.909997 0.36,-0.46 0.44,-0.9 0.26,-1.47 -1.54,-4.65 -3.05,-9.29 -4.58,-13.93 -0.09,-0.24 -0.16,-0.48 -0.23,-0.73 -0.03,-0.1 -0.06,-0.21 0.06,-0.27 0.09,-0.04 0.16,0.03 0.23,0.09 0.26,0.2 0.5,0.41 0.76,0.61 7.07,5.52 14.15,11.04 21.22,16.54 l 7.49,5.82 c 0.21,0.17 0.43,0.34 0.71,0.36 0.37,0 0.51,-0.16 0.36,-0.48 -0.16,-0.31 -0.36,-0.61 -0.54,-0.91 -4.74,-7.13 -9.48,-14.25 -14.21,-21.39 -0.41,-0.63 -0.88,-0.88 -1.63,-0.87 -4.26,0.03 -8.53,0 -12.79,0 h -0.71 c -0.16,0 -0.31,-0.04 -0.37,-0.21 -0.06,-0.17 0.04,-0.29 0.17,-0.39 0.27,-0.21 0.53,-0.43 0.8,-0.63 8.69,-6.579998 17.36,-13.149998 26.04,-19.709998 0.77,-0.58 1.54,-1.18 2.3,-1.77 0.1,-0.09 0.26,-0.17 0.2,-0.33 -0.07,-0.17 -0.24,-0.16 -0.4,-0.11 -0.31,0.09 -0.63,0.17 -0.93,0.27 -7.97,2.71 -15.95,5.43 -23.92,8.14 -0.54,0.19 -0.84,0.48 -0.98,1.04 -0.63,2.21 -1.28,4.41 -1.94,6.6 -0.57,1.93 -1.14,3.839998 -1.71,5.759998 -0.07,0.21 -0.09,0.53 -0.4,0.51 -0.3,0 -0.3,-0.33 -0.37,-0.54 0,-0.04 -0.03,-0.1 -0.04,-0.14 -1.75,-5.929998 -3.49,-11.869998 -5.25,-17.789998 -1.48,-5.01 -2.97,-10 -4.45,-14.99 -0.09,-0.3 -0.14,-0.63 -0.46,-0.86 v -0.07 0 z"
          />
        </g>
        <g id="g147" transform="translate(-132.22424,-7.1405721)">
          <g id="g146" transform="translate(114.97919)">
            <text
              class="cls-20"
              id="text136-0"
              style="font-size:22px;font-family:BakbakOne-Regular, 'Bakbak One';letter-spacing:0.1em;fill:#000000"
              x="439.53033"
              y="136.44778"
            >
              <tspan
                x="328.20151"
                y="136.44778"
                id="tspan136-4"
                style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';text-align:center;text-anchor:middle;fill:#000000"
              >
                <%= (@name && String.upcase(@name) <> "'s") || "YOUR" %>
              </tspan>
            </text>
            <text class="cls-20" transform="translate(326.72,136.19)" id="text136" x="111.32881" y="0">
              <tspan
                x="0"
                y="0"
                id="tspan136"
                style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';text-align:center;text-anchor:middle"
              >
                <%= (@name && String.upcase(@name) <> "'s") || "YOUR" %>
              </tspan>
            </text>
          </g>
          <g id="g146-1" transform="translate(114.97919,25.910246)">
            <text
              class="cls-20"
              id="text136-0-7"
              style="font-size:22px;font-family:BakbakOne-Regular, 'Bakbak One';letter-spacing:0.1em;fill:#000000"
              x="439.53033"
              y="136.44778"
            >
              <tspan
                x="328.20151"
                y="136.44778"
                id="tspan136-4-2"
                style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';text-align:center;text-anchor:middle;fill:#000000"
              >
                TICKET BACK HOME
              </tspan>
            </text>
            <text
              class="cls-20"
              id="text136-7"
              style="font-size:22px;font-family:BakbakOne-Regular, 'Bakbak One';letter-spacing:0.1em;fill:#ffffff"
              x="111.32881"
              y="0"
              transform="translate(326.72,136.19)"
            >
              <tspan
                x="0"
                y="0"
                id="tspan136-2"
                style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';text-align:center;text-anchor:middle"
              >
                TICKET BACK HOME
              </tspan>
            </text>
          </g>
        </g>
        <text
          xml:space="preserve"
          style="font-size:14.1964px;font-family:Likhan;-inkscape-font-specification:Likhan;text-align:center;text-anchor:middle;fill:#ffffff;stroke-width:0.591518"
          x="176.38989"
          y="26.89325"
          id="text145"
        >
          <tspan
            id="tspan145"
            x="176.38989"
            y="26.89325"
            style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';stroke-width:0.591518"
          >
            Founder's Hall
          </tspan>
        </text>
        <text
          xml:space="preserve"
          style="font-size:14.1964px;font-family:Likhan;-inkscape-font-specification:Likhan;text-align:center;text-anchor:middle;fill:#ffffff;stroke-width:0.591518"
          x="186.64563"
          y="230.43054"
          id="text145-2"
        >
          <tspan
            id="tspan145-5"
            x="186.64563"
            y="230.43054"
            style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';stroke-width:0.591518"
          >
            Dec 7th
          </tspan>
        </text>
        <text
          xml:space="preserve"
          style="font-size:14.1964px;font-family:Likhan;-inkscape-font-specification:Likhan;text-align:center;text-anchor:middle;fill:#ffffff;stroke-width:0.591518"
          x="300.99716"
          y="230.32655"
          id="text145-2-4"
        >
          <tspan
            id="tspan145-5-7"
            x="300.99716"
            y="230.32655"
            style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';stroke-width:0.591518"
          >
            6:00 PM
          </tspan>
        </text>
        <text
          xml:space="preserve"
          style="font-size:14.1964px;font-family:Likhan;-inkscape-font-specification:Likhan;text-align:center;text-anchor:middle;fill:#ffffff;stroke-width:0.591518"
          x="421.62393"
          y="230.07008"
          id="text145-2-4-4"
        >
          <tspan
            id="tspan145-5-7-4"
            x="421.62393"
            y="230.07008"
            style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:'Century Schoolbook L';-inkscape-font-specification:'Century Schoolbook L';stroke-width:0.591518"
          >
            Price: $60
          </tspan>
        </text>
        <text
          xml:space="preserve"
          style="font-size:14.1964px;font-family:Likhan;-inkscape-font-specification:Likhan;text-align:center;text-anchor:middle;fill:#ffffff;stroke-width:0.591518"
          x="578.37683"
          y="51.884361"
          id="text145-1"
        >
          <tspan
            id="tspan145-2"
            x="578.37683"
            y="51.884361"
            style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:14.1964px;font-family:Sans;-inkscape-font-specification:'Sans, Bold';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.591518"
          >
            #201410
          </tspan>
        </text>
        <g
          class="cls-22"
          clip-path="url(#clippath-9)"
          id="g19-4"
          style="fill:#ffffff"
          transform="matrix(2.2413172,0,0,-2.0200202,-1127.2536,317.52127)"
        >
          <g class="cls-28" clip-path="url(#clippath-10)" id="g18-9" style="fill:#ffffff">
            <path
              class="cls-9"
              d="m 786.58,0 h 31.55 v 31.54 h -31.55 z"
              id="path17-0"
              style="fill:#ffffff;stroke-width:0px"
            />
          </g>
        </g>
      </g>
    </svg>
    """
  end
end
