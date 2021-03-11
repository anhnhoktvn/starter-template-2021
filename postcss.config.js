let fb = require('fast-glob')

const postcss = require('postcss');

module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
  ]
}
