package interaction {
	import flash.display.Sprite;
	import flash.events.Event;

	import sprites.Ball;

	//rubber band.
	public class Spring2 extends Sprite {
		private var ball:Ball;
		private var spring:Number = 0.1;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.95;
		private var gravity:Number = 5;

		public function Spring2() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			var dx:Number = mouseX - ball.x;
			var dy:Number = mouseY - ball.y;
			ball.ax = dx * spring;
			ball.ay = dy * spring;
			ball.vx += ball.ax;
			ball.vy += ball.ay;
			ball.vy += gravity;
			ball.vx *= friction;
			ball.vy *= friction;
			ball.x += ball.vx;
			ball.y += ball.vy;

			//rubber line.
			graphics.clear();
			graphics.lineStyle(1);
			graphics.moveTo(ball.x, ball.y);
			graphics.lineTo(mouseX, mouseY);
		}
	}
}