package anim {
	import flash.display.Sprite;
	import flash.events.Event;

	import sprites.Ball;

	public class AngleVelocity extends Sprite {
		private var ball:Ball;
		private var angle:Number = 45;
		private var speed:Number = 3;

		public function AngleVelocity() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = 50;
			ball.y = 100;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			var radians:Number = angle * Math.PI / 2;
			ball.vx = Math.cos(angle) * speed;
			ball.vy = Math.sin(angle) * speed;
			ball.x += ball.vx;
			ball.y += ball.vy;
		}
	}
}