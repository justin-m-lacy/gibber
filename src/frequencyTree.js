import FrequencyNode from './frequencyNode';

/**
 * Turns a list of items occuring with a given frequency into a tree that can be
 * queried for items in proportion to their occurance.
 */
export default class FrequencyTree {

	//public var head:FrequencyNode;

	//public var countProp;

	constructor() {
		this.countProp = '';
	}

	/**
	 * n is a number from 1 to the total number of all counts.
	 * If you picture as all the objects lined up with occurance equal to their counts,
	 * this function returns the object which occupies the n-th place in line.
	 * objects with high occurances will occupy more spaces.
	 */
	getItem(n) {

		var node = this.head;
		var nxt;

		while (node) {

			nxt = node.left;

			if (!nxt) return node.object;

			if (n <= nxt.count) {

				node = nxt;
				continue;

			} else {

				n -= nxt.count;
				node = node.right;

			} //

		} //

		return null;

	} //

	/**
	 * Get a random object in proportion to its frequency in the tree.
	 */
	getRandom() {

		// occurance number.
		var n = 1 + Math.floor( this.head.count * Math.random());

		var node = this.head;
		var nxt;

		while (node) {

			nxt = node.left;

			if (!nxt) return node.object;

			if (n <= nxt.count) {

				node = nxt;
				continue;

			} else {

				n -= nxt.count;
				node = node.right;

			} //

		} //

		return null;

	} //

	/**
	 * If the program changes the underlying frequencies of the stored objects,
	 * their counts need to be updated. This works whether the tree was previously
	 * optimized or not, but the resulting tree is no longer guaranteed to be
	 * optimal.
	 */
	updateCounts() {

		this.updateNodeCount(head);

	} //

	updateNodeCount(node) {

		if (node.left) {
			node.count = this.updateNodeCount(node.left) + this.updateNodeCount(node.right);
		} else {
			node.count = node.object[countProp];
		}

		return node.count;

	} //

	/**
	 * This does not give the most efficient encoding, in terms of moving objects with high probabilities
	 * further up the tree. It also doesn't give any huffman information about which objects are most probable.
	 * It merely allows you to get back random items in proportion to their counts.
	 * 
	 * If the tree becomes too large, or querying the tree becomes too slow, make a function to form the tree
	 * by always combining nodes with low probability counts. the most probable node then becomes head->left.
	 * in this case, data wouldn't be stored at the very bottom of the tree only.
	 * 
	 * countProp is the property for getting the count of an object.
	 */
	build( list, countProp) {

		this.countProp = countProp;

		if ( list.length === 0) {
			this.head = new FrequencyNode(null, 0);
			return;
		} //

		this.head = this.buildSubTree(list, 0, list.length - 1);

	} //

	buildSubTree( list, minIndex, maxIndex ) {

		var obj;

		var f1, f2;

		if (maxIndex === minIndex) {

			obj = list[minIndex];
			return new FrequencyNode( obj, obj[this.countProp] );

		} else if (maxIndex === minIndex + 1) {

			obj = list[minIndex];
			let obj2 = list[maxIndex];

			f1 = new FrequencyNode(obj, obj[this.countProp]);
			f2 = new FrequencyNode(obj2, obj2[this.countProp]);
			return new FrequencyNode(null, f1.count + f2.count, f1, f2);

		} //

		var mid = Math.floor((minIndex + maxIndex) / 2);

		f1 = this.buildSubTree(list, minIndex, mid);
		f2 = this.buildSubTree(list, mid + 1, maxIndex);

		return new FrequencyNode(null, f1.count + f2.count, f1, f2);

	} //

} // End FrequencyTree