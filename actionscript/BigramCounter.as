package {
	import flash.utils.Dictionary;

	/**
	 * Bigram counter tracks the occurances of bigrams that start with a specific word.
	 */
	public class BigramCounter {

		public var startWord:String;

		public var links:Dictionary;
		public var freqTree:FrequencyTree;

		/**
		 * Words that follow this one. Must be array for frequencyTree.
		 */
		public var words:Array;

		/**
		 * total bigrams which start with this word.
		 */
		public var count:int;

		public function BigramCounter( word:String ) {

			startWord = word;

			// Not quite accurate, because there are no following words.
			// This is useful as a total word count, though.
			count = 1;

			words = [];
			links = new Dictionary();

		} //

		/**
		 * Add an occurance of a word following this word.
		 * returns true if the word forms a new bigram,
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
		public function getRandom():String {

			var wd:WordData = freqTree.getRandom() as WordData;

			if ( wd == null ) {
				return "";
			}

			return wd.word;

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

	} // End Bigram

} // End package