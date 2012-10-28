package customCursor {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;

	public class ImageCursorSwitcher extends AbstractCursorSwitcher {

		public function ImageCursorSwitcher(uiComp:Sprite, cursor:DisplayObject) {
			super(uiComp, cursor);
		}

		override protected function positionCursor():void {
			//center cursor image.
			cursor.x = uiComp.stage.mouseX - cursor.width / 2;
			cursor.y = uiComp.stage.mouseY - cursor.height / 2;
		}
	}
}