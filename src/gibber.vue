<script>

import TrigramParser from './trigramParser';
import TextStream from './textStream';

/**
 * @constant {number} MAX_INPUT_SIZE - Maximum length of input text.
 */
const MAX_INPUT_SIZE = 2000;
/**
 * @constant {number} MAX_WORD_COUNT - maximum number of unique words to count.
 */
const MAX_WORD_COUNT = 1000;

export default {

	props:[],
	data(){

		return {
			parser:null,
			textStream:null,
			curText:''
		};
	},

	methods:{
	
		process( e ) {

			this.textStream = new TextStream( this.curText );

			this.parser = new TrigramParser();
			this.parser.readWordsFromStream( this.textStream );

			this.parser.buildFrequencyTrees();

			this.curText = this.parser.construct( 150 );

		},

		/**
		 * generate new text without reconstructing the textStream or parser.
		 */
		generate( e ) {

			this.curText = this.parser.construct( 150 );

		} //

	}

}

</script>

<template>

	<div>
		<div><h2 style="margin:10px 100px">Gibber</h2></div>
		<textarea v-model="curText" cols="70" rows="32"></textarea>
		<div>
		<input type="button" @click="process" id="btnProcess" name="btnProcess" value="Process" />
		<input type="button" :disabled="!curText" @click="generate" id="btnGenerate" name="btnGenerate" value="Generate" />
		</div>
	</div>

</template>