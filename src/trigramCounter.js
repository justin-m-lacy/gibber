import WordData from './wordData';
import FrequencyTree from './frequencyTree';

/**
	 * Trigram counter tracks the occurances of trigrams that start with a specific word.
	 * 
	 * The class assumes we don't need to know the probabilities of the intermediate
	 * bigrams that form the trigram. This makes the class more efficient and simplifies
	 * the coding.
	 */
export default class TrigramCounter {

	/**
	 * words that follow the given two words in sequence.
	 */
	//public var words: Array;

	/**
	 * total trigrams which start with these two words.
	 */
	//public var count;

	constructor(word1, word2) {

		this.firstWord = word1;
		this.secondWord = word2;

		// Not quite accurate, because there are no following words.
		// This is useful as a total word count, though.
		this.count = 1;

		this.words = [];
		this.links = {}

	} //

	/**
	 * Add an occurance of a word following this word.
	 * returns true if the word forms a new trigram,
	 * false otherwise.
	 */
	addWord(word) {

		this.count++;				// count the use of this particular starting word.

		var wd = this.links[word];
		if (wd) {

			wd.count++;
			return false;

		} else {

			wd = new WordData(word);
			this.words.push(wd);

			this.links[word] = new WordData(word);

			return true;

		} //

	} //

	/**
	 * return a random word based on the frequencytree.
	 */
	getRandom() {
		return this.freqTree.getRandom();
	} //

	/**
	 * Build a frequency tree for the words occuring in dictionary.
	 */
	buildTree() {

		this.freqTree = new FrequencyTree();

		this.freqTree.build( this.words, "count");

		// with everything stored in the tree, can provisionally delete extra variables.
		// might change this later on.
		this.links = null;
		this.words = null;

	} //

} // End TrigramCounter