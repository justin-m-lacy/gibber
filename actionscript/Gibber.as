package {

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	[ SWF( width="500", height="600", framerate="60" ) ]

	public class Gibber extends Sprite {

		// Maximum size of input text. won't use this for offline gibber - and online could use scrolling text window.
		static private var MAX_INPUT_SIZE:int = 20000;
		// Maximum number of unique words to allow.
		static public var MAX_WORD_COUNT:int = 1000;

		private var text:TextField;

		//private var parser:BigramParser;
		private var parser:TrigramParser;

		private var textStream:TextStream;

		private var btnGenerate:Sprite;

		public function Gibber() {

			initInterface();

		} //

		private function processText( e:MouseEvent ):void {

			textStream = new TextStream( text.text );

			parser = new TrigramParser();
			parser.readWordsFromStream( textStream );

			parser.buildFrequencyTrees();

			text.text = parser.construct( 150 );

			btnGenerate.addEventListener( MouseEvent.CLICK, this.generate );

		} //

		/**
		 * generate new text without reconstructing the textStream or parser.
		 */
		private function generate( e:MouseEvent ):void {

			text.text = parser.construct( 150 );

		} //

		private function initInterface():void {

			text = new TextField();
			text.background = true;
			text.selectable = true;
			text.multiline = true;
			text.type = TextFieldType.INPUT;
			text.wordWrap = true;

			text.border = true;

			text.x = 10;
			text.y = 60;
			text.width = 480;
			text.height = 500;

			this.addChild( text );

			makeButton( 10, 10, 0x0000EE, null, this.processText );
			btnGenerate = makeButton( 390, 10, 0xEE0000, "btnGenerate" );

		} //

		public function makeButton( x:Number, y:Number, color:uint, name:String=null, listener:Function=null ):Sprite {

			var btn:Sprite = new Sprite();

			if ( name != null ) {
				btn.name = name;
			}

			var g:Graphics = btn.graphics;

			g.clear();
			g.lineStyle( 2, 0, 1 );
			g.beginFill( color, 1 );
			g.drawRect( 0, 0, 100, 30 );
			g.endFill();
			
			this.addChild( btn );

			btn.x = x;
			btn.y = y;

			if ( listener != null ) {
				btn.addEventListener( MouseEvent.CLICK, listener );
			}

			return btn;

		} //

	} // End Gibber

} // End package