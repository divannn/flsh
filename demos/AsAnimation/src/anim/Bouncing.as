package anim {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import sprites.Ball;

	//[SWF(backgroundColor="0x00ff00", width="400",height="300")]
	public class Bouncing extends Sprite {
		private var ball:Ball;
		//simulates loss of energy after bounce.use -1 for everlasting bouncing.
		private var bounce:Number = -0.8;

		public function Bouncing() {
			init();
		}

		private function init():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			ball = new Ball();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			ball.vx = Math.random() * 20 - 10;
			ball.vy = Math.random() * 20 - 10;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void {
			ball.x += ball.vx;
			ball.y += ball.vy;
			var bounds:Rectangle = new Rectangle();
			bounds.left = 0;
			bounds.right = stage.stageWidth;
			bounds.top = 0;
			bounds.bottom = stage.stageHeight;
			if (ball.x + ball.radius > bounds.right) {
				ball.x = bounds.right - ball.radius;
				ball.vx *= bounce;
			} else if (ball.x - ball.radius < bounds.left) {
				ball.x = bounds.left + ball.radius;
				ball.vx *= bounce;
			}
			if (ball.y + ball.radius > bounds.bottom) {
				ball.y = bounds.bottom - ball.radius;
				ball.vy *= bounce;
			} else if (ball.y - ball.radius < bounds.top) {
				ball.y = bounds.top + ball.radius;
				ball.vy *= bounce;
			}
		}

	}
}