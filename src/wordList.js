import {EMPTY_STRING} from './textStream';

export default class WordList {

	constructor() {

		this.words = {};

		this.uniqueWords = 0;
		this.totalWords = 0;

	} // WordList

	readWordsFromStream(ts) {

		var word;
		var wordData;

		while ((word = ts.readWord()) !== EMPTY_STRING ) {

			wordData = this.words[word];
			if ( !wordData ) {

				wordData = this.words[word] = new WordData(word);
				this.uniqueWords++

			} //

			this.totalWords++;

		} // end-while.

	} // readWordsFromStream()

	getWordData(word) {

		return words[word];

	} //

	getUniqueWords() {
		return uniqueWords;
	}

	getTotalWords() {
		return totalWords;
	} //

} // End WordList