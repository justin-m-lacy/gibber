import WordData from './wordData';
import FrequencyTree from './frequencyTree';

export default class BigramCounter {

		/**
		 * Words that follow this one. Must be array for frequencyTree.
		 */
		//public var words:Array;

		/**
		 * total bigrams that start with this word.
		 */
		//public var count;

		constructor( word ) {

			this.startWord = word;

			// Not quite accurate, because there are no following words.
			// This is useful as a total word count, though.
			this.count = 1;
	
			this.freqTree = null;

			this.words = [];
			this.links = {};

		} //

		/**
		 * Add an occurance of a word following this word.
		 * returns true if the word forms a new bigram,
		 * false otherwise.
		 */
		addWord( word ) {

			this.count++;				// count the use of this particular starting word.

			var wd = this.links[ word ];
			if ( wd ) {

				wd.count++;
				return false;

			} else {

				wd = new WordData( word );
				this.words.push( wd );

				this.links[ word ] = new WordData( word );

				return true;

			} //

		} //

		/**
		 * return a random word based on the frequencytree.
		 */
		getRandom() {

			var wd = this.freqTree.getRandom();
			return wd ? wd.word : '';

		} //

		/**
		 * Build a frequency tree for the words occuring in dictionary.
		 */
		buildTree() {

			this.freqTree = new FrequencyTree();

			this.freqTree.build( words, "count" );

			// with everything safely stored in the tree, can provisionally delete our extra variables.
			// might change this later on.
			this.links = null;
			this.words = null;

		} //

	}