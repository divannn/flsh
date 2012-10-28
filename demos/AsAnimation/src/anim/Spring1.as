package anim {

	import flash.display.Sprite;
	import flash.events.Event;

	import sprites.Ball;

	//springing in 2 dimensions.
	public class Spring1 extends Sprite {
		private var ball:Ball;
		private var spring:Number = 0.1;
		private var targetX:Number = stage.stageWidth / 2;
		private var targetY:Number = stage.stageHeight / 2;
		private var friction:Number = 0.95;

		public function Spring1() {
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
			ball.ax = dx * spring;
			ball.ay = dy * spring;
			ball.vx += ball.ax;
			ball.vy += ball.ay;
			ball.vx *= friction;
			ball.vy *= friction;
			ball.x += ball.vx;
			ball.y += ball.vy;
		}
	}
}