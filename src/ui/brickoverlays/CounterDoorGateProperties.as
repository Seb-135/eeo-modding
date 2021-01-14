package ui.brickoverlays
{
	import blitter.Bl;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import items.ItemId;
	
	import ui2.ui2minusbtn;
	import ui2.ui2plusbtn;
	import ui2.ui2properties;
	
	import items.ItemManager;
	
	public class CounterDoorGateProperties extends PropertiesBackground{
		public function CounterDoorGateProperties(bricktype:int){
			
			var text1:String;
			var text2:String = "Colour:";

			if(bricktype == ItemId.DOOR_COUNTER){
				text1 = "Points to open door:";				
			}else{
				text1 = "Points to close gate:";								
			}
			
			var id:Sprite = createPointScroller(text1, "counter_doorgate_value", 1, 999, false)
			id.y = -39-25
				
			var target:Sprite = createPointScroller(text2, "counter_colour", 0, ItemManager.counterHexes.length-1, true)
			target.y = -39

			addChild(id);
			addChild(target);	
		
//			this.bg.height = 75;
			setSize(325,75);
		}
		
		private function createPointScroller(name:String, id:String, min:int, max:int, colourText:Boolean):Sprite{
			
			var container:Sprite = new Sprite();
			
			var tf:TextField = new TextField();
			tf.embedFonts = true;
			tf.selectable = false;
			tf.sharpness = 100;
			tf.multiline = false;
			tf.wordWrap = false;
			
			
			var tff:TextFormat = new TextFormat("system", 12, 0xffffff);
			tf.defaultTextFormat = tff;
			tf.width = 280;
			tf.x = -150;
			tf.y = 0;
			tf.text = name;
			tf.height = tf.textHeight;
			container.addChild(tf);
			
			var inptf:TextField = new TextField();
			if(!colourText) {
				inptf.type = TextFieldType.INPUT;
				inptf.restrict = "0-9";
				inptf.maxChars = 3;
			}
			inptf.selectable = true;
			inptf.sharpness = 100;
			inptf.multiline = false
			inptf.borderColor = 0xffffff;
			inptf.backgroundColor = 0xAAAAAA;
			inptf.background = true;
			inptf.border = true;
			
			inptf.addEventListener(Event.CHANGE, function(e:Event):void{
				var pid:int = parseInt(inptf.text);
				trace("Input: " + pid + " - " + inptf.text);
				if(!isNaN(pid) && pid >= min && pid <= max){
					Bl.data[id] = pid;
				}
				//inptf.text = Bl.data[id].toString();
			});
			
			var inptff:TextFormat = new TextFormat("Arial", 12, 0x0, null, null, null, null, null, TextFormatAlign.CENTER);
			inptf.defaultTextFormat = inptff;
			updateText(inptf, id, colourText);
			inptf.height = tf.height+3;
			inptf.width = colourText ? 75 : 30;
			inptf.x = colourText ? 50 : 95;
			inptf.y = 0;
			
			inptf.addEventListener(FocusEvent.FOCUS_IN, function(e:Event):void{
				e.preventDefault();
				e.stopImmediatePropagation();
				e.stopPropagation()
			});
			
			inptf.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void{
				e.preventDefault();
				e.stopImmediatePropagation();
				e.stopPropagation();
			})
			
			
			var add:ui2plusbtn = new ui2plusbtn();
			add.y = 9;
			add.x = inptf.x + inptf.width + add.width + 5;
			container.addChild(add);
			
			
			add.addEventListener(MouseEvent.MOUSE_DOWN, function():void{
				if(Bl.data[id]<max) Bl.data[id] ++
				updateText(inptf, id, colourText);
			});
			
			
			var sub:ui2minusbtn = new ui2minusbtn();
			sub.y = 9;
			sub.x = inptf.x - sub.width - 5;
			container.addChild(sub);
			
			sub.addEventListener(MouseEvent.MOUSE_DOWN, function():void{
				if(Bl.data[id]>min) Bl.data[id] --
				updateText(inptf, id, colourText);
			})
			
			container.addChild(inptf);
				
			return container
		}
		
		private function updateText(inptf:TextField, id:String, colourText:Boolean):void 
		{
			if (colourText) inptf.text = ItemManager.counterHexNames[Bl.data[id]];
			else inptf.text = Bl.data[id];
		}
		
	}
}