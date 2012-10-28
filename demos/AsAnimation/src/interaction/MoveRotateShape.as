package interaction {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;


	/**
	 * @author idanilov
	 */
	public class MoveRotateShape extends Sprite {

		private var s:Sprite;

		public function MoveRotateShape() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			s = new Sprite();
			s.x = 50;
			s.y = 30;

			addChild(s);
			//circle.
			//s.graphics.lineStyle(2, 0x000000);
			//s.graphics.beginFill(0x666666);
			//s.graphics.drawCircle(0, 0, 10);
			//s.graphics.endFill();

			//triangle.
			s.graphics.lineStyle(2, 0x000000);
			s.graphics.beginFill(0x999999);
			//			s.graphics.moveTo(25, 0);
			//			s.graphics.lineTo(50, 25);
			//			s.graphics.lineTo(0, 25);
			//			s.graphics.lineTo(25, 0);

			s.graphics.moveTo(0, -15);
			s.graphics.lineTo(10, 15);
			s.graphics.lineTo(-10, 15);
			s.graphics.lineTo(0, -15);
			s.graphics.endFill();

			s.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownStage);
		}

		//		private function onMouseDownStage(e:MouseEvent):void {
		//			trace("mouse down global: " + e.localX + "," + e.localY + " target: " + e.target);
		//		}

		private function onMouseDown(e:MouseEvent):void {
			trace("mouse down local: " + e.localX + "," + e.localY);
			trace("mouse down stage: " + e.stageX + "," + e.stageY);
		}

		private function keyDownHandler(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.RIGHT:
					if (e.ctrlKey) {
						s.rotation += 10;
					} else {
						s.x += 10;
					}
					break;
				case Keyboard.LEFT:
					if (e.ctrlKey) {
						s.rotation -= 10;
					} else {
						s.x -= 10;
					}
					break;
				case Keyboard.UP:
					s.y -= 10;
					break;
				case Keyboard.DOWN:
					s.y += 10;
					break;
			}

		}

	}
}