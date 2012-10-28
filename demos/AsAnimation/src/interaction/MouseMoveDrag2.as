package interaction {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import sprites.Ball;

	//dragging with startDrag/stopDrag
	public class MouseMoveDrag2 extends Sprite {
		private var ball:Ball;

		public function MouseMoveDrag2() {
			init();
		}

		private function init():void {
			ball = new Ball();
			ball.x = 100;
			ball.y = 100;
			addChild(ball);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onMouseDown(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.startDrag();
			//restrict dragging bounds.
			//ball.startDrag(false, new Rectangle(100, 100, 200, 200));
		}

		private function onMouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
		}

	}
}