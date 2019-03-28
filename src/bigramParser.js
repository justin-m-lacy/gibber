import {EMPTY_STRING} from './textStream';

export default class BigramParser {

	//private var totalWords;
	// var totalBigrams;

	// Matches strings to BigramCount object that gives probabilities of each following word.
	//private var bigrams:Dictionary;

	//private var bigramList:Array;

	//private var freqTree:FrequencyTree;

	BigramParser() {

		this.bigrams = new Dictionary();

		this.uniqueBigrams = 0;
		this.uniqueWords = 0;
		this.totalBigrams = 0;

	} // WordList

	readWordsFromStream(ts) {

		var word = ts.readWord();
		if ( word === EMPTY_STRING) return;

		var bigram = new BigramCounter(word);
		this.bigrams[word] = bigram;

		while ((word = ts.readWord()) !== EMPTY_STRING) {

			// add a link from the current bigram start to the next word.
			// returns true if the resulting bigram is unqiue.
			if ( bigram.addWord(word) ) {
				this.uniqueBigrams++;
			}
			this.totalBigrams++;

			bigram = this.bigrams[word];
			if ( !bigram ) {

				bigram = new BigramCounter(word);
				this.bigrams[word] = bigram;

			} //

		} // end-while.

	} // readWordsFromStream()

	construct(numBigrams) {

		var bigram = this.getRandomBigram();
		if (!bigram) return EMPTY_STRING;

		var result = bigram.startWord;
		var nextWord;

		while (numBigrams-- > 0) {

			nextWord = bigram.getRandom();
			if (nextWord === "" ) {

				// No word following this bigram. get a different word.
				bigram = this.getRandomBigram();
				result += " " + nextWord;

			} else {

				result += " " + nextWord;
				bigram = this.bigrams[nextWord];

			} //

		} // end-while.

		return result;

	} //

	// could construct this based on a tree or something.
	getRandomBigram() {

		// why does this work? because eventually the total counts subtracted, must be greater than any one given count.
		var n = 1 + Math.floor( Math.random() * this.totalBigrams );

		for ( var s in this.bigrams ) {

			var biCounter = this.bigrams[s];

			// think n == max, and b.count == 1 is the final one that gets looked at.
			if ( biCounter.count >= n ) {
				return this.biCounter;
			} //
			n -= biCounter.count;

		} //

		return null;

	} //

	buildFrequencyTrees() {

		for (var s in this.bigrams) {

			this.bigrams[s].buildTree();

		} //

	} //

	getUniqueWords() {
		return this.uniqueWords;
	}

} // End WordList