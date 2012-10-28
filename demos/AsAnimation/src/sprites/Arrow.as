package sprites {
	import flash.display.Sprite;

	public class Arrow extends Sprite {
		public function Arrow() {
			init();
		}

		public function init():void {
			graphics.lineStyle(1, 0, 1);
			graphics.beginFill(0xffff00);
			graphics.moveTo(-30, -15);
			graphics.lineTo(0, -15);
			graphics.lineTo(0, -30);
			graphics.lineTo(30, 0);
			graphics.lineTo(0, 30);
			graphics.lineTo(0, 15);
			graphics.lineTo(-30, 15);
			graphics.lineTo(-30, -15);
			graphics.endFill();
			
			//center.
			graphics.beginFill(0x00);
			graphics.drawCircle(0, 0, 1);
			graphics.endFill();

		}
	}
}