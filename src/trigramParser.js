import { EMPTY_STRING } from './textStream';
import TrigramCounter from './trigramCounter';

const separator = '*';

export default class TrigramParser {

	/*private var uniqueWords;
	private var uniqueTrigrams;

	private var totalWords;
	private var totalTrigrams;*/

	/**
	 * Matches trigrams in the form of firstWord*secondWord to bigram objects.
	 * This is used to check if a given bigram exists while forming new
	 * objects.
	 */
	//private var trigrams;
	//private var freqTree:FrequencyTree;

	constructor() {

		this.trigrams = [];

		this.totalWords = 0;
		this.uniqueTrigrams = 0;
		this.uniqueWords = 0;
		this.totalTrigrams = 0;

	} //

	readWordsFromStream(ts) {

		var word = ts.readWord();
		if (word === EMPTY_STRING) return;

		var nextWord = ts.readWord();
		if (nextWord === EMPTY_STRING) return;

		var key = word + separator + nextWord;
		var trigram = new TrigramCounter(word, nextWord);
		this.trigrams[key] = trigram;

		this.totalTrigrams = 1;				// not quite true, but TrigramCounters start at 1.

		word = nextWord;

		while ((nextWord = ts.readWord()) !== EMPTY_STRING) {

			// Add the current sequence of three to the current trigramCounter ( which already has 2 words )
			if (trigram.addWord(nextWord)) {
				this.uniqueTrigrams++;
			}
			this.totalTrigrams++;

			// Look for a trigram counter matching the next sequence of two words:
			key = word + separator + nextWord;
			trigram = this.trigrams[key];
			if (!trigram) {

				trigram = new TrigramCounter(word, nextWord);
				this.trigrams[key] = trigram;

				this.totalTrigrams++;

			} //

			word = nextWord;

		} // end-while.

	} // readWordsFromStream()

	construct(numBigrams) {

		var trigram = this.getRandomTrigram();
		if (!trigram) {
			return "";
		}

		var result = trigram.firstWord;
		result = this.addResult(result, trigram.secondWord);

		var nextWord;

		while (numBigrams-- > 0) {

			nextWord = trigram.getRandom();
			if (nextWord == null) {

				// No words for this trigram. apparently.
				trigram = this.getRandomTrigram();
				result = this.addResult(result, trigram.firstWord);
				result = this.addResult(result, trigram.secondWord);

			} else {

				result = this.addResult(result, nextWord.word);

				// Get the trigram for the next series of two words.
				trigram = this.trigrams[(trigram.secondWord + separator + nextWord.word)];
				if (trigram == null) {
					// this should never happen because the previous two words
					// already occured in a trigram.
					trigram = this.getRandomTrigram();
					result = this.addResult(result, trigram.firstWord);
					result = this.addResult(result, trigram.secondWord);
				}

			} //

		} // end-while.

		return result;

	} //

	addResult(res, word) {

		if (word === "." || word === "," || word === ";") return (res + word);		// No space.
		else return (res + " " + word);

	} //

	// could construct this based on a tree or something.
	getRandomTrigram() {

		// why does this work? because eventually the total counts subtracted, must be greater than any one given count.
		var n = 1 + Math.floor(Math.random() * this.totalTrigrams);

		var triCounter;

		for (var s in this.trigrams) {

			triCounter = this.trigrams[s];

			// think n == max, and b.count == 1 is the final one that gets looked at.
			if (triCounter.count >= n) {
				return triCounter;
			} //
			n -= triCounter.count;

		} //

		return null;

	} //

	buildFrequencyTrees() {

		for (var s in this.trigrams) {

			this.trigrams[s].buildTree();

		} //

	} //

	getUniqueWords() {
		return uniqueWords;
	}

	getTotalWords() {
		return totalWords;
	} //

}