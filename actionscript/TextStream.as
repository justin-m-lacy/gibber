package {

	public class TextStream {

		static public var EMPTY_STRING:String = "";

		static public var ERROR:int = -1;
		static public var START:int = 0;

		static public var SPACE:int = 0x20;
		static public var TAB:int = 0x09;
		static public var LINE_FEED:int = 0x0A;
		static public var CARRIAGE_RETURN:int = 0x0D;

		static public var LOWER_CASE_START:int = 97;
		static public var LOWER_CASE_END:int = 122;
		static public var UPPER_CASE_START:int = 65;
		static public var UPPER_CASE_END:int = 90;

		static public var NUMBERS_START:int = 48;
		static public var NUMBERS_END:int = 57;

		static public var PERIOD:int = 47;
		static public var SEMICOLON:int = 59;

		private var prevPosition:int;
		private var curPosition:int;

		private var maxPosition:int;

		private var text:String;

		public function TextStream( start_text:String="" ) {

			text = start_text;

			maxPosition = start_text.length;

			if ( maxPosition > 0 ) {
				curPosition = START;
			} else {
				curPosition = ERROR;
			}

		} //

		public function addText( txt:String ):void {

			text += txt;
			maxPosition += txt.length;

		} //

		public function readWord():String {

			while( isWhitespace(curPosition) ) {

				curPosition++;
				if ( eof() ) {
					return EMPTY_STRING;
				}

			} //

			var start:int = curPosition;
			curPosition++;
			while ( !eof() && !whitespace() && alphanumeric() ) {
				curPosition++
			}

			return text.slice( start, curPosition );

		} //

		public function eof():Boolean {
			return ( curPosition>maxPosition );
		} //

		public function alphanumeric():Boolean {

			var char:Number = text.charCodeAt( curPosition );

			if ( char >= NUMBERS_START && char <= NUMBERS_END ) {
				return true;
			}
			if ( char >= LOWER_CASE_START && char <= LOWER_CASE_END ) {
				return true;
			}
			if ( char >= UPPER_CASE_START && char <= UPPER_CASE_END ) {
				return true;
			}

			return false;

		} //

		public function isDigit():Boolean {

			var char:Number = text.charCodeAt( curPosition );

			if ( char >= NUMBERS_START && char <= NUMBERS_END ) {
				return true;
			}

			return false;

		} //

		public function whitespace():Boolean {

			var char:Number = text.charCodeAt( curPosition );

			if ( char == SPACE || char == CARRIAGE_RETURN || char == LINE_FEED || char == TAB ) {
				return true;
			}

			return false;
			
		} //

		public function isWhitespace( pos:int ):Boolean {

			var char:Number = text.charCodeAt( pos );

			if ( char == SPACE || char == CARRIAGE_RETURN || char == LINE_FEED || char == TAB ) {
				return true;
			}

			return false;

		} //

	} // End TextStream
	
} // End package