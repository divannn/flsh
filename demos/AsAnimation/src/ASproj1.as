package {
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import flashx.textLayout.events.UpdateCompleteEvent;

	import org.osmf.display.ScaleMode;

	public class ASproj1 extends Sprite {

		private var text:TextField = new TextField();

		private var old:Date;

		public function ASproj1() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			text.border = true;
			//			text.x = 10;
			//			text.y = 10;
			addChild(text);
			positionText();

			var shape:Shape = new Shape();
			shape.graphics.lineStyle(1, 0xFF00FF, 1.0, false, ScaleMode.NONE);
			shape.graphics.lineTo(20, 30);
			this.addChild(shape);

			addEventListener(Event.ENTER_FRAME, frameEnterHandler);

			stage.addEventListener(Event.RESIZE, resizeHandler);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}

		private function resizeHandler(event:Event):void {
			positionText();
		}

		//place text field to upper right corner of the stage.
		private function positionText():void {
			text.x = stage.stageWidth - text.width - 1;
			text.y = 0;
		}

		private function frameEnterHandler(event:Event):void {
			var now:Date = new Date();
			var fps:Number = 0;
			if (old != null) {
				fps = 1000 / (now.time - old.time);
			}
			old = now;
			//trace("    FPS: " + fps);
			text.text = "X=" + mouseX + "Y=" + mouseY;
		}

		private function mouseMoveHandler(e:MouseEvent):void {

			//			trace("stage1: " + stage.width + "," + stage.height);
			//			trace("stage2: " + stage.stageWidth + "," + stage.stageHeight);
			//			trace("OWN: " + width + "," + width);

			//trace("stage: " + e.stageX + "," + e.stageY);
			//trace("OWN: " + mouseX + "," + mouseY);
			//trace("event: " + e.localX + "," + e.localY);
			graphics.lineStyle(1, 0x0000FF, 1.0, false, ScaleMode.NONE);
			//graphics.lineTo(mouseX, mouseY);

			//			graphics.beginFill(0x00FFFF00);
			//			graphics.drawRect(x, y, width, height);
			//			graphics.endFill();
		}
	}
}