package {

	import flash.utils.Dictionary;

	public class BigramParser {

		public var maxUniqueWords:int = 1000;
		public var maxBigrams:int = 4000;

		private var uniqueWords:int;
		private var uniqueBigrams:int;

		//private var totalWords:int;
		private var totalBigrams:int;

		// Matches strings to BigramCount object that gives probabilities of each following word.
		private var bigrams:Dictionary;

		//private var bigramList:Array;

		private var freqTree:FrequencyTree;

		public function BigramParser() {

			bigrams = new Dictionary();

			uniqueBigrams = 0;
			uniqueWords = 0;
			totalBigrams = 0;

		} // WordList

		public function readWordsFromStream( ts:TextStream ):void {

			var word:String = ts.readWord();
			if ( word == TextStream.EMPTY_STRING ) {
				return;
			}

			var bigram:BigramCounter = new BigramCounter( word );
			bigrams[ word ] = bigram;
			//var nextWord:String;

			while ( (word = ts.readWord()) != TextStream.EMPTY_STRING ) {

				// add a link from the current bigram start to the next word.
				// returns true if the resulting bigram is unqiue.
				if ( bigram.addWord( word ) ) {
					uniqueBigrams++;
				}
				totalBigrams++;

				bigram = bigrams[ word ];
				if ( bigram == null ) {

					bigram = new BigramCounter( word );
					bigrams[ word ] = bigram;

				} //

			} // end-while.

		} // readWordsFromStream()

		public function construct( numBigrams:int ):String {

			var bigram:BigramCounter = getRandomBigram();
			if ( bigram == null ) {
				return "";
			}

			var result:String = bigram.startWord;
			var nextWord:String;

			while ( numBigrams-- > 0 ) {

				nextWord = bigram.getRandom();
				if ( nextWord == "" ) {

					// No word following this bigram. get a different word.
					bigram = getRandomBigram();
					result += " " + nextWord;

				} else {

					result += " " + nextWord;
					bigram = bigrams[ nextWord ];

				} //

			} // end-while.

			return result;

		} //

		// could construct this based on a tree or something.
		public function getRandomBigram():BigramCounter {

			// why does this work? because eventually the total counts subtracted, must be greater than any one given count.
			var n:int = 1 + Math.floor( Math.random()*totalBigrams );

			var b:BigramCounter;

			for( var s:String in bigrams ) {

				b = bigrams[s];

				// think n == max, and b.count == 1 is the final one that gets looked at.
				if ( b.count >= n ) {
					return b;
				} //
				n -= b.count;

			} //

			return null;

		} //

		public function buildFrequencyTrees():void {

			for( var s:String in bigrams ) {

				bigrams[s].buildTree();

			} //

		} //

		/*// no reason for this atm.
		public function buildFrequencyTree():void {
		} //*/

		public function getUniqueWords():int {
			return uniqueWords;
		}

		/*public function getTotalWords():int {
			return totalWords;
		} //*/

	} // End WordList

} // End package