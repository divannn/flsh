package interaction {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class StarShipGame extends Sprite {
		private var ship:Ship;
		private var vr:Number = 0;
		private var thrust:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;

		public function StarShipGame() {
			init();
		}

		private function init():void {
			ship = new Ship();
			addChild(ship);
			ship.x = stage.stageWidth / 2;
			ship.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					vr = -5;
					break;
				case Keyboard.RIGHT:
					vr = 5;
					break;
				case Keyboard.UP:
					thrust = 0.2;
					ship.draw(true);
					break;
				default:
					break;
			}
		}

		private function onKeyUp(event:KeyboardEvent):void {
			vr = 0;
			thrust = 0;
			ship.draw(false);
		}

		private function onEnterFrame(event:Event):void {
			ship.rotation += vr;
			var angle:Number = ship.rotation * Math.PI / 180;
			var ax:Number = Math.cos(angle) * thrust;
			var ay:Number = Math.sin(angle) * thrust;
			vx += ax;
			vy += ay;
			ship.x += vx;
			ship.y += vy;
		}
	}
}
import flash.display.Sprite;

class Ship extends Sprite {
	public function Ship() {
		draw(false);
	}

	public function draw(showFlame:Boolean):void {
		graphics.clear();
		graphics.lineStyle(1, 0x00);
		graphics.moveTo(10, 0);
		graphics.lineTo(-10, 10);
		graphics.lineTo(-5, 0);
		graphics.lineTo(-10, -10);
		graphics.lineTo(10, 0);
		if (showFlame) {
			graphics.lineStyle(1, 0xff0000);
			graphics.moveTo(-7.5, -5)
			graphics.lineTo(-15, 0);
			graphics.lineTo(-7.5, 5);
		}
	}
}