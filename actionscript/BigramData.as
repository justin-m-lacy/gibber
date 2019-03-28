package {

	public class BigramData {

		/**
		 * Number of times bigram occurs in text.
		 */
		public var count:uint;

		public var firstWord:String;
		public var secondWord:String;

		public function BigramData( first:String, second:String ) {

			firstWord = first;
			secondWord = second;

			count = 1;

		} //

	} // End Bigram

} // End package