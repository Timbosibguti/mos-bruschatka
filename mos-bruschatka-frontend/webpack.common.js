const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {

	entry: {
		'app': './src/app.js'
	},

	externals: {
		jquery: 'jQuery',
	},

	optimization: {
		splitChunks: {
			cacheGroups: {
				vendors: {
					test: /[\\/]node_modules[\\/]/,
					name: 'vendors',
					chunks: 'all'
				},
			}
		}
	},

	resolve: {
		modules: ["node_modules", "spritesmith-generated"]
	},

	module: {
		rules: [
			{
				test: /\.js?x$/,
				exclude: /(node_modules|bower_components)/,
				use: [
					{
						loader: 'babel-loader',
						options: {
							presets: ['@babel/preset-env']
						}
					}
				]
			},

			{
				test: /\.s?css$/,
				use: [
					{
						loader: MiniCssExtractPlugin.loader,
					},
					{
						loader: 'css-loader',
					},
					{
						loader: 'postcss-loader',
					},
					{
						loader: 'sass-loader'
					}
				]
			},
			{
				test: /\.(png|svg|jpg|jpeg|gif)$/,
				use: [
					{
						loader: 'file-loader',
						options: {
							outputPath: 'img/',
							publicPath: '../img/'
						}
					}
				]
			},
			{
				test: /\.(woff|woff2|eot|ttf|otf)$/,
				use: [
					{
						loader: 'file-loader',
						options: {
							outputPath: 'fonts/',
						}
					}
				]
			},
		]
	}
};
