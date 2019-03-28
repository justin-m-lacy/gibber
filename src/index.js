import Vue from 'vue';
import Gibber from './gibber.vue';

var vm = new Vue({
	el: '#vueRoot',
	components:{ Gibber },
	render( createElm ) {
		return createElm(Gibber, { props:{} } );
	}

});