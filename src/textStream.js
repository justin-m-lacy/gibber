const EMPTY_STRING = "";

const ERROR = -1;
const START = 0;

const SPACE = 0x20;
const TAB = 0x09;
const LINE_FEED = 0x0A;
const CARRIAGE_RETURN = 0x0D;

const LOWER_CASE_START = 97;
const LOWER_CASE_END = 122;
const UPPER_CASE_START = 65;
const UPPER_CASE_END = 90;

const NUMBERS_START = 48;
const NUMBERS_END = 57;

const PERIOD = 47;
const SEMICOLON = 59;

export { EMPTY_STRING };

export default class TextStream {

	constructor( start_text = '' ) {

		this.text = start_text;

		this.maxPosition = start_text.length;

		if (this.maxPosition > 0) this.curPosition = START;
		else this.curPosition = ERROR;

	} //

	addText(txt) {

		this.text += txt;
		this.maxPosition += txt.length;

	} //

	readWord() {

		while (this.isWhitespace(this.curPosition)) {
			if ( ++this.curPosition >= this.maxPosition) return EMPTY_STRING;
		} //

		var start = this.curPosition;
		this.curPosition++;

		while (!this.eof() && !this.whitespace() && this.alphanumeric()) {
			this.curPosition++
		}

		return this.text.slice( start, this.curPosition );

	} //

	eof() {
		return ( this.curPosition >= this.maxPosition );
	} //

	alphanumeric() {

		var char = this.text.charCodeAt( this.curPosition );

		return (char >= NUMBERS_START && char <= NUMBERS_END) ||
			(char >= LOWER_CASE_START && char <= LOWER_CASE_END) ||
			(char >= UPPER_CASE_START && char <= UPPER_CASE_END);

	} //

	isDigit() {

		var char = this.text.charCodeAt(this.curPosition);

		return (char >= NUMBERS_START && char <= NUMBERS_END);

	} //

	whitespace() {

		var char = this.text.charCodeAt(this.curPosition);

		return (char === SPACE || char === CARRIAGE_RETURN || char === LINE_FEED || char === TAB);

	} //

	isWhitespace(pos) {

		var char = this.text.charCodeAt(pos);

		return (char === SPACE || char === CARRIAGE_RETURN || char === LINE_FEED || char === TAB);

	} //

} // End TextStream