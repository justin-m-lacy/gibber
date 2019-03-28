package {

	import flash.utils.Dictionary;

	/**
	 * Trigram counter tracks the occurances of trigrams that start with a specific word.
	 * 
	 * The class assumes we don't need to know the probabilities of the intermediate
	 * bigrams that form the trigram. This makes the class more efficient and simplifies
	 * the coding.
	 */
	public class TrigramCounter {

		//static public var separator:String = "*";

		public var firstWord:String;
		public var secondWord:String;

		public var links:Dictionary;
		public var freqTree:FrequencyTree;

		/**
		 * words that follow the given two words in sequence.
		 */
		public var words:Array;

		/**
		 * total trigrams which start with these two words.
		 */
		public var count:int;

		public function TrigramCounter( word1:String, word2:String ) {

			firstWord = word1;
			secondWord = word2;

			// Not quite accurate, because there are no following words.
			// This is useful as a total word count, though.
			count = 1;

			words = [];
			links = new Dictionary();

		} //

		/**
		 * Add an occurance of a word following this word.
		 * returns true if the word forms a new trigram,
		 * false otherwise.
		 */
		public function addWord( word:String ):Boolean {

			count++;				// count the use of this particular starting word.

			var wd:WordData = links[ word ];
			if ( wd ) {

				wd.count++;
				return false;

			} else {

				wd = new WordData( word );
				words.push( wd );

				links[ word ] = new WordData( word );

				return true;

			} //

		} //

		/**
		 * return a random word based on the frequencytree.
		 */
		public function getRandom():WordData {

			//var bd:BigramData = freqTree.getRandom() as BigramData;

			return freqTree.getRandom() as WordData;

		} //

		/**
		 * Build a frequency tree for the words occuring in dictionary.
		 */
		public function buildTree():void {

			freqTree = new FrequencyTree();

			freqTree.build( words, "count" );

			// with everything safely stored in the tree, can provisionally delete our extra variables.
			// might change this later on.
			links = null;
			words = null;

		} //

	} // End TrigramCounter

} // End package