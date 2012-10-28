package anim {
	import flash.display.Sprite;
	import flash.events.Event;

	import sprites.Ball;

	public class Easing extends Sprite {
		private var ball:Ball;
		private var easing:Number = 0.1;
		private var targetX:Number = stage.stageWidth / 2;
		private var targetY:Number = stage.stageHeight / 2;

		public function Easing() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			var dx:Number = targetX - ball.x;
			var dy:Number = targetY - ball.y;
			if (Math.abs(dx) < 1 || Math.abs(dy) < 1) {
				//				ball.x = targetX;
				//				ball.y = targetY;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				trace("easing done");
			} else {
				ball.vx = dx * easing;
				ball.vy = dy * easing;
				ball.x += ball.vx;
				ball.y += ball.vy;
			}


		}
	}
}