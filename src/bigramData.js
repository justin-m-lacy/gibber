export default class BigramData {

		/**
		 * 
		 * @param {string} w1 - first word of bigram.
		 * @param {string} w2 - second word of bigram.
		 */
		constructor( w1, w2 ) {

			this.word1 = w1;
			this.word2 = w2;

			this.count = 1;

		} //

	} // End Bigram