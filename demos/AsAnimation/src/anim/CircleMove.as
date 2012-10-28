package anim {
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sprites.Ball;

	public class CircleMove extends Sprite {
		private var ball:Ball;
		private var angle:Number = 0;
		private var centerX:Number = 200;
		private var centerY:Number = 200;
		private var radiusX:Number = 100;
		private var radiusY:Number = 50;
		private var speed:Number = .1;

		public function CircleMove() {
			init();
		}

		private function init():void {
			ball = new Ball();
			addChild(ball);
			ball.x = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(event:Event):void {
			ball.x = centerX + Math.sin(angle) * radiusX;
			ball.y = centerY + Math.cos(angle) * radiusY;
			angle += speed;
		}
	}
}