package {

	/**
	 * Turns a list of items occuring with a given frequency, into a tree that can be
	 * queried for items in proportion to their occurance.
	 */
	public class FrequencyTree {

		public var head:FrequencyNode;

		public var countProp:String;

		public function FrequencyTree() {
		} //

		/**
		 * n is a number from 1 to the total number of all counts.
		 * If you picture as all the objects lined up with occurance equal to their counts,
		 * thiis function returns the object which occupies the n-th place in line.
		 * objects with high occurances will occupy more spaces.
		 */
		public function getItem( n:int ):Object {

			var node:FrequencyNode = head;
			var nxt:FrequencyNode;

			while ( node ) {

				nxt = node.left;
				
				if ( nxt == null ) {
					return node.object;
				}
				
				if ( n <= nxt.count ) {
					
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
		public function getRandom():Object {

			// occurance number.
			var n:int = 1 + Math.floor( head.count*Math.random() );

			var node:FrequencyNode = head;
			var nxt:FrequencyNode;

			while ( node != null ) {

				nxt = node.left;

				if ( nxt == null ) {
					return node.object;
				}

				if ( n <= nxt.count ) {

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
		public function updateCounts():void {

			updateNodeCount( head );

		} //

		public function updateNodeCount( node:FrequencyNode ):int {

			if ( node.left ) {
				node.count = updateNodeCount( node.left ) + updateNodeCount( node.right );
			} else {
				node.count = node.object[ countProp ];
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
		public function build( list:Array, countProp:String ):void {

			this.countProp = countProp;

			if ( list.length == 0 ) {
				head = new FrequencyNode( null, 0 );
				return;
			} //

			head = buildSubTree( list, 0, list.length-1 );

		} //

		/**
		 * Build the frequency list from objects found in a dictionary.
		 * Does not build an optimized tree.
		 */
		/*public function buildFrom( d:Dictionary, countProp ):void {

			this.countProp = countProp;

			// for now going to do this the lazy way.
		} //*/

		private function buildSubTree( list:Array, minIndex:int, maxIndex:int ):FrequencyNode {

			var obj:Object;

			var f1:FrequencyNode
			var f2:FrequencyNode

			if ( maxIndex == minIndex ) {

				obj = list[minIndex];
				return new FrequencyNode( obj, obj[countProp] );

			} else if ( maxIndex == minIndex+1 ) {

				obj = list[ minIndex ];
				var obj2:Object = list[ maxIndex ];

				f1 = new FrequencyNode( obj, obj[ countProp ] );
				f2 = new FrequencyNode( obj2, obj2[ countProp ] );
				return new FrequencyNode( null, f1.count + f2.count, f1, f2 );

			} //

			var mid:int = Math.floor( ( minIndex + maxIndex ) / 2 );

			f1 = buildSubTree( list, minIndex, mid );
			f2 = buildSubTree( list, mid+1, maxIndex );

			return new FrequencyNode( null, f1.count + f2.count, f1, f2 );

		} //

	} // End FrequencyTree

} // End package