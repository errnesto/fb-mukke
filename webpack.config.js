var webpack = require('webpack')

module.exports = {
  entry: ['webpack/hot/dev-server', './app/client.js'],
  output: {
    path:       __dirname + '/public',
    filename:   'bundle.js'
  },

  module: {
    loaders: [
      { test: /\.(js|tag)$/, exclude: /node_modules/, loader: '6to5-loader!riotjs-loader' }, // use ! to chain loaders
      { test: /\.styl$/, loader: 'style-loader!css-loader!stylus-loader' },
      { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192' }, // inline base64 URLs for <=8k images, direct URLs for the rest
      { test: /\.svg$/, loader: 'file-loader' }
    ]
  },

  plugins: [new webpack.HotModuleReplacementPlugin()],
}

