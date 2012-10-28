package customCursor {

	import flash.display.Sprite;
	import flash.text.TextField;

	[Embed(source="/customCursor/CursorCrosshair.swf",
			symbol="CrosshairCursor")]
	public class CrosshairCursor extends Sprite {
		public var xValue:TextField;
		public var yValue:TextField;

		public function CrosshairCursor() {
			super();
		/*  Without the line below, the code wouldn't work. Why?
			The portion of board hidden under the custom cursor (which is a MovieClip and
			thus an InteractiveObject) would not receive mouse events; disk would receive them.
			Try commenting the line out, and decyphering the havoc that happens.
			It does follow logically from the way event listeners below are assigned. */
			mouseEnabled = false;
		}

	}
}