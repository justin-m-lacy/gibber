package {

	import flash.utils.Dictionary;

	public class WordList {

		private var words:Dictionary;

		private var uniqueWords:int;
		private var totalWords:int;

		public function WordList() {

			words = new Dictionary();

			uniqueWords = 0;
			totalWords = 0;

		} // WordList

		public function readWordsFromStream( ts:TextStream ):void {

			var word:String;
			var wordData:WordData;

			while ( (word = ts.readWord()) != TextStream.EMPTY_STRING ) {

				wordData = words[ word ];
				if ( wordData == null ) {

					wordData = words[ word ] = new WordData( word );
					uniqueWords++

				} //

				totalWords++;

			} // end-while.

		} // readWordsFromStream()

		public function getWordData( word:String ):WordData {
			
			return words[ word ];
			
		} //

		public function getUniqueWords():int {
			return uniqueWords;
		}

		public function getTotalWords():int {
			return totalWords;
		} //

	} // End WordList

} // End package