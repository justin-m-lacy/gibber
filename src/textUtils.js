export default {

		EMPTY_STRING:"",
		
		ERROR:-1,
		START:0,
		
		SPACE:0x20,
		TAB:0x09,
		LINE_FEED:0x0A,
		CARRIAGE_RETURN:0x0D,
		
		LOWER_CASE_START:97,
		LOWER_CASE_END:122,
		UPPER_CASE_START:65,
		UPPER_CASE_END:90,
		
		NUMBERS_START:48,
		NUMBERS_END:57,
		
		PERIOD:47,
		SEMICOLON:59,

		isAlphanumeric( char ) {

			return ( char >= NUMBERS_START && char <= NUMBERS_END ) ||
			( char >= LOWER_CASE_START && char <= LOWER_CASE_END ) ||
			 ( char >= UPPER_CASE_START && char <= UPPER_CASE_END );
			
		},

		isDigit( char ) {

			return ( char >= NUMBERS_START && char <= NUMBERS_END );

		},
		
		whitespace( char ) {

			return ( char === SPACE || char === CARRIAGE_RETURN || char === LINE_FEED || char === TAB );

		} //

} // End TextUtils
