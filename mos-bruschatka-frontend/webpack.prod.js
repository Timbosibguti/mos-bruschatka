const merge = require('webpack-merge');
const path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const SpritesmithPlugin = require('webpack-spritesmith');
const common = require('./webpack.common.js');

const destFolder = 'dist';

module.exports = merge(common,{
	mode: 'production',

	output: {
		path: path.resolve(__dirname, destFolder),
		filename: 'js/[name].js',
    },
    
    plugins: [
		new CleanWebpackPlugin([destFolder]),
		new MiniCssExtractPlugin({
			filename: "css/[name].css",
		}),
		new SpritesmithPlugin({
			src: {
				cwd: path.resolve(__dirname, 'src/icons'),
				glob: '*.png'
			},
			target: {
				image: path.resolve(__dirname, 'src/img/icons.png'),
				css: path.resolve(__dirname, 'src/styles/01-base/_icons.scss')
			},
			apiOptions: {
				cssImageRef: "../img/icons.png"
			}
		})
	]
});
