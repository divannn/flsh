package anim {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import sprites.Ball;

	public class JumpingBall extends Sprite {
		protected var ball:Ball;
		private var bounce:Number = -0.9;
		private var gravity:Number = 0.5;

		public function JumpingBall() {
			init();
		}

		protected function init():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			ball = new Ball();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			ball.vx = Math.random() * 10 - 5;
			ball.vy = -10;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		protected function onEnterFrame(event:Event):void {
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			var left:Number = 0;
			var right:Number = stage.stageWidth;
			var top:Number = 0;
			var bottom:Number = stage.stageHeight;
			if (ball.x + ball.radius > right) {
				ball.x = right - ball.radius;
				ball.vx *= bounce;
			} else if (ball.x - ball.radius < left) {
				ball.x = left + ball.radius;
				ball.vx *= bounce;
			}
			if (ball.y + ball.radius > bottom) {
				ball.y = bottom - ball.radius;
				ball.vy *= bounce;
			} else if (ball.y - ball.radius < top) {
				ball.y = top + ball.radius;
				ball.vy *= bounce;
			}
		}

	}
}