package {
	
	public class FrequencyNode {

		public var count:int;
		public var object:*;

		public var left:FrequencyNode;
		public var right:FrequencyNode;

		public function FrequencyNode( obj:*, count:uint, left:FrequencyNode=null, right:FrequencyNode=null ) {

			object = obj;
			this.count = count;

			this.left = left;
			this.right = right;

		} //

	} // End FrequencyNode
	
} // End package