package customCursor {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	import mx.events.ToolTipEvent;


	/**
	 * Shows how to add custom cursor on mouse move over sprite.
	 * Uses stage to add cursor.
	 * @author idanilov
	 */
	public class CustomCursorDemo extends Sprite {

		private var board1:Sprite;
		private var board2:Sprite;

		private var cursor1:Sprite;

		[Embed(source="/customCursor/tool_cursor.png")]
		private var toolCursorClass:Class;
		private var cursor2:Bitmap;

		public function CustomCursorDemo() {
			board1 = new Sprite();
			board1.x = 50;
			board1.y = 50;
			this.addChild(board1);

			drawBoard(board1);
			board2 = new Sprite();
			board2.x = 300;
			board2.y = 50;
			drawBoard(board2);
			this.addChild(board2);

			cursor1 = new CrosshairCursor();
			cursor2 = new toolCursorClass();
			new AnimatedCursorSwitcher(board1, cursor1).install();
			new ImageCursorSwitcher(board2, cursor2).install();
		}

		private function drawBoard(board:Sprite):void {
			board.graphics.lineStyle(1, 0x000000);
			board.graphics.beginFill(0xFFFFFF);
			board.graphics.drawRect(0, 0, 200, 200);
			board.graphics.endFill();
			board.filters = [new DropShadowFilter()];
		}

	}
}