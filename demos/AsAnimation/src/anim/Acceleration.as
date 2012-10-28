package anim {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import sprites.Ball;

	public class Acceleration extends Sprite {
		private var ball:Ball;

		public function Acceleration() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					ball.ax = -0.2;
					break;
				case Keyboard.RIGHT:
					ball.ax = 0.2;
					break;
				case Keyboard.UP:
					ball.ay = -0.2;
					break;
				case Keyboard.DOWN:
					ball.ay = 0.2;
					break;
				default:
					break;
			}
		}

		private function onKeyUp(event:KeyboardEvent):void {
			ball.ax = 0;
			ball.ay = 0;
		}

		private function onEnterFrame(event:Event):void {
			ball.vx += ball.ax;
			ball.vy += ball.ay;
			ball.x += ball.vx;
			ball.y += ball.vy;
		}
	}
}