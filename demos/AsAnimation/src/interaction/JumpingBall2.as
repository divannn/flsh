package interaction {
	import anim.JumpingBall;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import sprites.Ball;

	public class JumpingBall2 extends JumpingBall {

		public function JumpingBall2() {
			super();
		}

		override protected function init():void {
			super.init();
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onMouseDown(event:MouseEvent):void {
			ball.vx = 0;
			ball.vy = 0;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.startDrag();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onMouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}