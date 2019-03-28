package {

	import flash.utils.Dictionary;

	public class TrigramParser {

		static public var separator:String = "*";

		public var maxUniqueWords:int = 1000;
		public var maxTrigrams:int = 4000;

		private var uniqueWords:int;
		private var uniqueTrigrams:int;

		private var totalWords:int;
		private var totalTrigrams:int;

		/**
		 * Matches trigrams in the form of firstWord*secondWord to bigram objects.
		 * This is used to check if a given bigram exists while forming new
		 * objects.
		 */
		private var trigrams:Dictionary;

		private var freqTree:FrequencyTree;

		public function TrigramParser() {

			trigrams = new Dictionary();

			totalWords = 0;
			uniqueTrigrams = 0;
			uniqueWords = 0;
			totalTrigrams = 0;

		} // WordList

		public function readWordsFromStream( ts:TextStream ):void {

			var word:String = ts.readWord();
			if ( word == TextStream.EMPTY_STRING ) {
				return;
			}
			var nextWord:String = ts.readWord();
			if ( nextWord == TextStream.EMPTY_STRING ) {
				return;
			}

			var key:String = word + separator + nextWord;
			var trigram:TrigramCounter = new TrigramCounter( word, nextWord );
			trigrams[ key ] = trigram;

			totalTrigrams = 1;				// not quite true, but TrigramCounters start at 1.

			word = nextWord;

			while ( (nextWord = ts.readWord()) != TextStream.EMPTY_STRING ) {

				// Add the current sequence of three to the current trigramCounter ( which already has 2 words )
				if ( trigram.addWord( nextWord ) ) {
					uniqueTrigrams++;
				}
				totalTrigrams++;

				// Look for a trigram counter matching the next sequence of two words:
				key = word + separator + nextWord;
				trigram = trigrams[ key ];
				if ( trigram == null ) {

					trigram = new TrigramCounter( word, nextWord );
					trigrams[ key ] = trigram;

					totalTrigrams++;

				} //

				word = nextWord;

			} // end-while.

		} // readWordsFromStream()

		public function construct( numBigrams:int ):String {

			var trigram:TrigramCounter = getRandomTrigram();
			if ( trigram == null ) {
				return "";
			}

			var result:String = trigram.firstWord;
			result = addResult( result, trigram.secondWord );

			var key:String;
			var nextWord:WordData;

			while ( numBigrams-- > 0 ) {

				nextWord = trigram.getRandom();
				if ( nextWord == null ) {

					// No words for this trigram. apparently.
					trigram = getRandomTrigram();
					result = addResult( result, trigram.firstWord );
					result = addResult( result, trigram.secondWord );

				} else {

					result = addResult( result, nextWord.word );

					// Get the trigram for the next series of two words.
					trigram = trigrams[ (trigram.secondWord + separator + nextWord.word) ];
					if ( trigram == null ) {
						// this should never happen because the previous two words
						// already occured in a trigram.
						trigram = getRandomTrigram();
						result = addResult( result, trigram.firstWord );
						result = addResult( result, trigram.secondWord );
					}

				} //

			} // end-while.

			return result;

		} //

		private function addResult( res:String, word:String ):String {

			if ( word == "." || word == "," || word == ";" ) {
				return ( res + word );		// No space.
			} else {
				return ( res + " " + word );
			}

		} //

		// could construct this based on a tree or something.
		public function getRandomTrigram():TrigramCounter {

			// why does this work? because eventually the total counts subtracted, must be greater than any one given count.
			var n:int = 1 + Math.floor( Math.random()*totalTrigrams );

			var b:TrigramCounter;

			for( var s:String in trigrams ) {

				b = trigrams[s];

				// think n == max, and b.count == 1 is the final one that gets looked at.
				if ( b.count >= n ) {
					return b;
				} //
				n -= b.count;

			} //

			return null;

		} //

		public function buildFrequencyTrees():void {

			for( var s:String in trigrams ) {

				trigrams[s].buildTree();

			} //

		} //

		/*// no reason for this atm.
		public function buildFrequencyTree():void {
		} //*/

		public function getUniqueWords():int {
			return uniqueWords;
		}

		public function getTotalWords():int {
			return totalWords;
		} //

	} // End WordList

} // End package