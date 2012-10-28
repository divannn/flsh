package anim {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import sprites.Ball;

	//good way.
	public class Friction1 extends Sprite {
		private var ball:Ball;
		private var friction:Number = 0.1;

		public function Friction1() {
			init();
		}

		private function init():void {
			ball = new Ball();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			ball.vx = Math.random() * 10 - 5;
			ball.vy = Math.random() * 10 - 5;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			var speed:Number = Math.sqrt(ball.vx * ball.vx + ball.vy * ball.vy);
			var angle:Number = Math.atan2(ball.vy, ball.vx);
			if (speed > friction) {
				speed -= friction;
			} else {
				speed = 0;
			}
			ball.vx = Math.cos(angle) * speed;
			ball.vy = Math.sin(angle) * speed;
			ball.x += ball.vx;
			ball.y += ball.vy;
		}
	}
}