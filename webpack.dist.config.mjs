const path = require( 'path' );
const VueLoader = require('vue-loader/lib/plugin' );

module.exports = {

	mode:"production",
	entry:{
		gibber:"./src/index.js"
	},
	output:{

		path:path.resolve( __dirname, "dist"),
		publicPath:"dist/",
		filename:"[name].dist.bundle.js",
		chunkFilename:"dist/[name].bundle.js",
		library:"gibber"
	},
	module:{
		rules:[
			{
				test:/\.vue$/,
				loader:'vue-loader'
			}
		]
	},
	plugins:[ new VueLoader()],
	resolve:{
		modules:[
			path.resolve( __dirname, "src"),
			"node_modules"
		],

		alias:{
		}
	}

};