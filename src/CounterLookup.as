package 
{
	public class CounterLookup {
		public var value:int = 0;
		public var colourIndex:int = 0;
		public var collected:Boolean = false;
		
		public function CounterLookup(value:int, colourIndex:int, collected:Boolean = false) 
		{
			this.value = value;
			this.colourIndex = colourIndex;
			this.collected = collected;
		}
	}
}