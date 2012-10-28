package customCursor {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class AbstractCursorSwitcher {
		protected var uiComp:DisplayObject;
		protected var cursor:DisplayObject;

		public function AbstractCursorSwitcher(uiComp:DisplayObject,
				cursor:DisplayObject) {
			this.uiComp = uiComp;
			this.cursor = cursor;
		}

		public function install():void {
			uninstall();
			uiComp.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			uiComp.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			uiComp.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}

		public function uninstall():void {
			removeCursor();
			uiComp.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			uiComp.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			uiComp.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}

		private function setCursor():void {
			Mouse.hide();
			uiComp.stage.addChild(cursor);
			positionCursor();
		}

		private function removeCursor():void {
			if (uiComp.stage.contains(cursor)) {
				uiComp.stage.removeChild(cursor);
				Mouse.show();
			}
		}

		protected function positionCursor():void {
			cursor.x = uiComp.stage.mouseX;
			cursor.y = uiComp.stage.mouseY;
		}

		protected function mouseOver(e:MouseEvent):void {
			//trace("=over");
			setCursor();
		}

		protected function mouseOut(e:MouseEvent):void {
			//trace("=out " + uiComp.width);
			removeCursor();
		}


		protected function mouseMove(e:MouseEvent):void {
			//trace("=move ");
			positionCursor();
			e.updateAfterEvent();
		}
	}
}