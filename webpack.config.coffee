minify = process.env.NODE_ENV == 'production'
webpack = require 'webpack'
ExtractText = require 'extract-text-webpack-plugin'
autoprefixer = require 'autoprefixer'

# Autoprefixer config
# https://github.com/ai/browserslist#queries
autoprefixer = autoprefixer browsers: [
	'last 2 versions'
	'ie >= 9'
]

module.exports =

	entry: index: './index.vue'

	plugins: [
		new ExtractText '[name].css', allChunks: true
	]

	module: rules: [
		# { test: /\.coffee$/, loader: 'coffee-loader' }
		# { test: /\.jade$/, loader: 'apply-loader!jade-loader' }
		# { test: /\.vue$/, loader: 'vue-loader' }
		#

		{
			test: /\.vue$/
			loader: 'vue-loader'
			options:

				# Export common JS friendly modules
				esModule: false

				# Passthrough autoprefixer rules:
				postcss: [ autoprefixer ]

				# Set the doctype to html so that boolean attributes work as expected
				# https://pugjs.org/language/attributes.html#boolean-attributes
				# https://github.com/vuejs/vue-loader/issues/55#issuecomment-272837311
				template: doctype: 'html'

				# Support the css precompilers being explicitly defined
				loaders: stylus: ExtractText.extract use: [
					{
						loader: 'css-loader'
						options: minimize: minify
					}
					{
						loader: 'stylus-loader'
						options: preferPathResolver: 'webpack' # Faster
					}
				]
		}
	]

	output:
		library: 'vue-height-tween-transition'
		libraryTarget: 'umd'
		filename: if minify then '[name].min.js' else '[name].js'

	# Every non-relative module is external
	# externals: [
	# 	/^[a-z\-0-9]+$/,
	# ]

# Turn off warnings during minifcation.  They aren't particularly helpfull.
# if minify then module.exports.plugins = module.exports.plugins.concat [
# 	new webpack.optimize.UglifyJsPlugin compress: warnings: false
# ]
