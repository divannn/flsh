package customCursor {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;

	public class AnimatedCursorSwitcher extends AbstractCursorSwitcher {

		public function AnimatedCursorSwitcher(uiComp:Sprite,
				cursor:DisplayObject) {
			super(uiComp, cursor);
		}

		override protected function mouseMove(e:MouseEvent):void {
			cursor["xValue"].text = Math.round(uiComp.mouseX).toString();
			cursor["yValue"].text = Math.round(uiComp.mouseY).toString();
			super.mouseMove(e);
		}
	}
}