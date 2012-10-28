package anim {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import sprites.Ball;

	//easy way.
	public class Friction2 extends Sprite {
		private var ball:Ball;
		private var friction:Number = 0.9;

		public function Friction2() {
			init();
		}

		private function init():void {
			ball = new Ball();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			ball.vx = Math.random() * 40 - 20;
			ball.vy = Math.random() * 40 - 20;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			ball.x += ball.vx;
			ball.y += ball.vy;
			ball.vx *= friction;
			ball.vy *= friction;
		}
	}
}