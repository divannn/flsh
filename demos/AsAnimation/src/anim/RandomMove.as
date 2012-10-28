package anim {
	import flash.display.Sprite;
	import flash.events.Event;

	import sprites.Ball;

	public class RandomMove extends Sprite {
		private var ball:Ball;
		private var angleX:Number = 0;
		private var angleY:Number = 0;
		private var centerX:Number = 200;
		private var centerY:Number = 200;
		private var range:Number = 50;

		public function RandomMove() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = 0;
			ball.y = 0;
			ball.vx = 0.07;
			ball.vy = 0.11;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(event:Event):void {
			ball.x = centerX + Math.sin(angleX) * range;
			ball.y = centerY + Math.sin(angleY) * range;
			angleX += ball.vx;
			angleY += ball.vy;
		}
	}
}
