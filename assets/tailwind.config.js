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
    "../lib/ora_web/**/*.*ex"
  ],
  theme: {
    extend: {
      animation: {
        marquee: 'marquee 30s linear infinite',
        gradient: 'gradient-anim 30s ease infinite',
      },
      keyframes: {
        marquee: {
          '0%': {transform: 'translateY(0)'},
          '100%': {transform: 'translateY(-100em)'},
        },
        'gradient-anim': {
          '0%': { backgroundPosition: '0% 0%' },
          '10%': { backgroundPosition: '50% 0%' },
          '20%': { backgroundPosition: '80% 70%' },
          '30%': { backgroundPosition: '20% 30%' },
          '36%': { backgroundPosition: '0% 20%' },
          '55%': { backgroundPosition: '100% 0%' },
          '64': { backgroundPosition: '100% 100%' },
          '72%': { backgroundPosition: '0% 100%' },
          '80%': { backgroundPosition: '0% 90%' },
          '88%': { backgroundPosition: '100% 0%' },
          '100%': { backgroundPosition: '100% 100%' },
        }
      },
      fontFamily: {
        rome: ['"Karm"', "sans-serif"],
        cent: ['"Vyas", "sans-serif"']
      },
      colors: {
        brand: "#006837",
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
