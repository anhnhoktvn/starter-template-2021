let pkg = require('./package.json')
module.exports = {
    css: {
    extract: {
      filename: "all.css?v=" + pkg.version
    }
  },
  chainWebpack: (config) => {
    config.optimization.delete('splitChunks')
    config.plugin('define').tap((definitions) => {
      definitions[0]['require.extensions'] = false
      return definitions;
    });
  },

  devServer: {
      watchOptions: {
          poll: true
      },
      host: 'localhost'
  },

  configureWebpack: {
    node: {
      fs: "empty"
    },
    output: {
      filename: "all.js?v=" + pkg.version
    }
  },
}
