package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;


	public class ASproj2 extends Sprite {

		private var s:Sprite;

		public function ASproj2() {
			s = new Sprite();
			addChild(s);

			var t:Timer = new Timer(500);
			t.addEventListener(TimerEvent.TIMER, l);
			t.start();

			var v:Object = {};
			var v2:Object = v;
			switch (v) {
				case v2:
					trace("OK");
					break;
				default:
					trace("NO");
			}
		}

		public function l(e:TimerEvent):void {
			s.graphics.clear();
			s.graphics.lineStyle(Math.random() * 10, 0xFF00FF);
			s.graphics.moveTo(Math.random() * 500, Math.random() * 500);
			s.graphics.lineTo(Math.random() * 500, Math.random() * 500);
		}
	}
}