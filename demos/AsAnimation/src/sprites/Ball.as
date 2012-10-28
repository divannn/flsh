package sprites {
	import flash.display.Sprite;

	public class Ball extends Sprite {
		public var radius:Number = 0;
		public var color:uint;
		
		//x,y velocity.
		public var vx:Number = 0;
		public var vy:Number = 0;

		//x,y acceleration.
		public var ax:Number = 0;
		public var ay:Number = 0;

		public function Ball(radius:Number = 20, color:uint = 0xff0000) {
			this.radius = radius;
			this.color = color;
			init();
		}

		public function init():void {
			graphics.beginFill(color);
			//graphics.lineStyle(1, 0x0);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	}
}