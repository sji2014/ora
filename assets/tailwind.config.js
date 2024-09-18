// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "./svelte/**/*.svelte",
    "../lib/ora_web.ex",
    "../lib/ora_web/**/*.*ex",
    "../lib/ora_web/live/*.*ex"
  ],
  theme: {
    extend: {
      transitionDuration: {
        '5000': '5000ms',
      },
      animation: {
        marquee: 'marquee 30s linear infinite',
        gradient: 'gradient-anim 30s ease infinite',
        flicker: 'flicker 3s linear infinite',
        fade: 'fadeIn 1s ease-in-out'
      },
      keyframes: {
        fadeIn: {
					from: { opacity: 0 },
					to: { opacity: 1 },
				},
        marquee: {
          '0%': {transform: 'translateY(50vh)'},
          '50%': {transform: 'translateY(-80vh)'},
          '100%': {transform: 'translateY(88vh)'},
        },
        'gradient-anim': {
          '0%': { backgroundPosition: '0% 0%' },
          '10%': { backgroundPosition: '20% 0%' },
          '20%': { backgroundPosition: '40% 0%' },
          '30%': { backgroundPosition: '20% 30%' },
          '36%': { backgroundPosition: '0% 0%' },
          '72%': { backgroundPosition: '36% 36%' },
          '80%': { backgroundPosition: '45% 45%' },
          '88%': { backgroundPosition: '20% 20%' },
          '100%': { backgroundPosition: '0% 0%' },
        },
        flicker: {
          "0%, 19.9%, 22%, 62.9%, 64%, 64.9%, 70%, 100%": {
            opacity: 0.99,
            textShadow: 
            "-1px -1px 0 rgba(255, 255, 255, 0.6), " + 
              "1px -1px 0 rgba(255, 255, 255, 0.6), " + 
              "-1px 1px 0 rgba(255, 255, 255, 0.6), " + 
              "1px 1px 0 rgba(255, 255, 255, 0.6), " + 
              "0 -2px 8px rgba(255, 255, 255, 0.8), " + 
              "0 0 2px rgba(255, 255, 255, 0.8), " + 
              "0 0 5px rgba(255, 255, 255, 0.9), " + 
              "0 0 15px rgba(200, 200, 255, 0.7), " + 
              "0 0 20px rgba(200, 200, 255, 0.5), " + 
              "0 2px 3px #00664f"
          },
          "20%, 21.9%, 63%, 63.9%, 65%, 69.9%": {
            opacity: 0.4,
            textShadow: "none"
          }
        }
    },
    fontFamily: {
      rome: ['"Karm"', "sans-serif"],
        cent: ['"Vyas", "sans-serif"']
      },
      colors: {
        brand: "#006837",
        sji: "#00664f",
        offwhite: "#faf9f6",
        brandDark: "#333333"
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
