/*
This class controls ll the logic that drives the global game relate functionality
*/

package
{ 
	import flash.display.*
	import flash.text.*
	import flash.events.*
	import flash.net.URLRequest;
	import flash.system.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	public class Game extends MovieClip
	{
		//this static main property can be used to refer to this game object from anywhere easily using Game.main
 		static public var main;
		//these values just store the width and height of the game
		static public var WIDTH:int = 650;
		static public var HEIGHT:int = 300;
		
		//this property will just reference the hero ship
		public var ship:Ship;
		
		//These are stats we can will track in our game
		public var gameComplete:int;
		public var kills:int;
		public var misses:int;
		public var hits:int;
		public var points:int;
		public var shots:int;
		public var aliensCaptured:int;
		public var aliensCapturedInAir:int;
		public var aliensEjected:int;
		public var isPlaying:Boolean = false;
		public var isMouseDown:Boolean = false;
		public var pauseOverlay:MovieClip = new PauseOverlay();
	    public var rotateMessage:MovieClip = new RotateMessage();
	    
		//there are two modes of play, normal and hard
		public var difficultyMode:String; //"Normal" "Hard"
		//we store these modes in static properties so we can refer to them easily
		static public var NORMAL:String = "Normal";
		static public var HARD:String = "Hard";
		
		// Kongregate API reference: used if we want to add the Kongregate stats api to our game
		//public var kongregate:*
		
		//This is the Document Class in our fla, and it will get constructed when we launch the swf
		public function Game()
		{
		    // Example of how to sitelock for either the Kongregate website or app
		    var url:String = root.loaderInfo.url;
           	var kongMobileApp:Boolean = !!root.loaderInfo.parameters.kongregate_mobile_app;        	
           	var authorized:Boolean = ((kongMobileApp && url.indexOf("content://chat.kongregate.com/") == 0)
           	                         || url.indexOf("http://chat.kongregate.com/") == 0); 
            authorized = true;									 
           	if(!authorized)
           	{
           	    stop();
           	    return;
           	}
           	
			//set the static main property to this game object so we can always just use "Game.main" to refer to our game from other classes
			main = this;
			
			//hide some ui buttons
			playNowButton.visible = false;
			normalButton.visible = false;
			hardButton.visible = false;
			rotateMessage.visible = false;
			
			//add a loader to the game using these two event listeners
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			
			// It is IMPORTANT to listen for this event as opposed to waiting for the progress
    		// to equal 100%, since some web servers or applications might not fire progress events!
			loaderInfo.addEventListener(Event.COMPLETE,completeListener);
			addChild(FrameTimer.instance);
			
			// Pause overlay
			pauseOverlay.visible = false;
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
			pauseOverlay.addEventListener(MouseEvent.CLICK, onPauseOverlayClicked);
			addChild(pauseOverlay);
			
			// Rotate phone message
			rotateMessage.visible = false;
			rotateMessage.x = 187;
			rotateMessage.y = -100;
			addChild(rotateMessage);
			
			// Listen for touch events to set the ship target
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
           	stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
           	stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
           	           	
		}
		
		private function mouseDown(e:MouseEvent)
		{
		    if(isPlaying)
		    {
		        isMouseDown = true;
		        mouseMove(e);
		    }
		}
		
		private function mouseMove(e:MouseEvent)
		{
		    // If the game is being played
		    if(isPlaying && isMouseDown)
		    {
		        // If the distance is far enough away from the ship, set a new target. You can play with this
		        // number a bit to see what feels "right" when dragging your finger around.
		        var distance:Number = Math.abs(ship.xTarget - e.stageX) + Math.abs(ship.yTarget - e.stageY);
		        if(distance >= 20)
		        {
		            ship.xTarget = e.stageX;
    	            ship.yTarget = e.stageY;
	            }
		    }
		}
		
		private function mouseUp(e:MouseEvent)
		{
		    isMouseDown = false;
		    if(isPlaying)
		    {
		        // Set the ship's x and y target to the last known touch position
		        ship.xTarget = ship.x;
		        ship.yTarget = ship.y;
		    }
		}
		
        private function enterFrame(e:Event)
        {
            // If we're not in fullscreen mode, show the pause overlay and pause the game.
            if(stage.displayState == StageDisplayState.NORMAL)
            {
                if( isPlaying && !pauseOverlay.visible )
                {
                    pauseOverlay.visible = true;
                    FrameTimer.pause();
                }
                rotateMessage.visible = false;
            }
            else
            {
                rotateMessage.visible = true;
            }
        }
        
        private function onPauseOverlayClicked(e:MouseEvent)
        {
            // If the pause overlay is clicked, attempt to enter fullscreen mode and resume the game.
            try{
                pauseOverlay.visible = false;
                FrameTimer.unpause();
                stage.displayState = StageDisplayState.FULL_SCREEN;
            }catch(e:Error){
                
            }
        }
		
		//used to track the progress of this loading swf
		public function progressHandler(e:ProgressEvent):void
		{			//update te loader bar as all the game sounds and bitmaps load
			loaderBar.meter.scaleX = e.bytesLoaded / e.bytesTotal;
		}
		
		//when the game is done loading, hide the loading meter, and show the ui buttons
		// It is IMPORTANT to listen for this event as opposed to waiting for the progress
		// to equal 100%, since some web servers or applications might not fire progress events!
		public function completeListener(e:Event):void
		{
			loaderBar.visible = false;
			playNowButton.visible = true;
			//fire onPlay event when the user clicks the play button
			playNowButton.addEventListener(MouseEvent.CLICK, onPlay);
			
		}
		
		//on play, show the normal and hard mode buttons
		public function onPlay(e:MouseEvent)
		{
			//hide the play button
			playNowButton.visible = false;
			playNowButton.removeEventListener(MouseEvent.CLICK, onPlay);
			//show the difficulty mode buttons
			normalButton.visible = true;
			hardButton.visible = true;
			//add listeners for when these buttons are pressed
			normalButton.addEventListener(MouseEvent.CLICK, onNormal);
			hardButton.addEventListener(MouseEvent.CLICK, onHard);
			
		}
		
		//if normal mode button is pressed
		public function onNormal(e:MouseEvent)
		{
			//set the mode in this class too
			difficultyMode = NORMAL;
			gotoAndStop(2);
			//start game
			initGame();
		}
		
		public function onHard(e:MouseEvent)
		{
			//set the mode in this class too
			difficultyMode = HARD;
			gotoAndStop(2);
			//start game
			initGame();
		}
		
		//when a game is started
		public function initGame()
		{
		    isPlaying = true;
		    
			//start the level manager that makes timers for power up intervals, enemy ship intervals, and miniboss intervals, etc...
			LevelManager.init();
			//resets all stats to zero for new game
			initStats();
			//make a new hero ship and position it in the middle of the stage			
			ship = new Ship(WIDTH/2, HEIGHT/2);
			//display the new hero ship
			spriteClip.addChild(ship);
			
			//hide the game over menu and alien counter
			gameOverMenu.visible = false;
			alienCounter.visible = false;
			alienCounter.aliensCaptured.text = 0;
				
		}
		
		//After game over, this event will fire when the play again NORMAL mode button is pressed
		public function onPlayAgainNormal(e:MouseEvent)
		{
			//remove the button event listeners
			gameOverMenu.normalButton.removeEventListener(MouseEvent.CLICK, onPlayAgainNormal);
			gameOverMenu.hardButton.removeEventListener(MouseEvent.CLICK, onPlayAgainHard);
			//set this game's mode
			difficultyMode = NORMAL;
			
			//If using the Kong api: set the Kongregate HighScores api mode
			//kongregate.scores.setMode(NORMAL);
			
			//start a new game
			initGame();
			//reset the background
			bg.reset();	
		}
		
		//After game over, this event will fire when the play again HARD mode button is pressed
		public function onPlayAgainHard(e:MouseEvent)
		{
			//remove the button event listeners
			gameOverMenu.hardButton.removeEventListener(MouseEvent.CLICK, onPlayAgainHard);
			gameOverMenu.normalButton.removeEventListener(MouseEvent.CLICK, onPlayAgainNormal);
			//set this game's mode
			difficultyMode = HARD;
			
			//start a new game
			initGame();
			//reset the background
			bg.reset();	
		}
		
		//this method resets the stats to zero for a new game
		public function initStats()
		{
			scoreText.text = String(0);
			kills = 0;
			hits = 0;
			points = 0;
			misses = 0;
			shots = 0;
			aliensCaptured = 0;
			aliensEjected = 0;
			gameComplete = 0;
			aliensCapturedInAir = 0;
			
		}
		
		//update game stats, this method is called from throughout the classes whenever a stat needs to be updated
		public function updateStat(stat:String, val:int)
		{
			//the name of the game stat is passed in along with the value to increment it by
			Game.main[stat] += val;
			scoreText.text = String(points);
			
			//update the Kongregate API stat if we are using the kongregate API
			
			//IF we are using the kong api, submit stats
			/*
			switch(stat)
			{
				case "aliensCaptured":
					Game.main.kongregate.stats.submit( "AliensCapturedLife" , Game.main.aliensCaptured);
					Game.main.kongregate.stats.submit( "AliensCapturedMax" , Game.main.aliensCaptured);
					break;
				case "aliensCapturedInAir":
					Game.main.kongregate.stats.submit( "AliensCapturedInAirMax" , Game.main.aliensCapturedInAir);
				case "gameComplete":
					kongregate.stats.submit( "GameComplete" , gameComplete);
					break;
				case "kills":
					kongregate.stats.submit( "KillsMax" , kills);
					break;
				default:
					break;
			}
			*/
						
		}
		
		//this mehtod id called when the game is over
		public function gameOver()
		{
			//show the play again buttons
			gameOverMenu.normalButton.addEventListener(MouseEvent.CLICK, onPlayAgainNormal);
			gameOverMenu.hardButton.addEventListener(MouseEvent.CLICK, onPlayAgainHard);
			
			var ac;
			var h;
			
			//stop the background
			bg.disable();
			//show the game over menu
			gameOverMenu.visible = true;
			
			//stop all the imers that level mamager started
			LevelManager.main.stop();
			//destroy all enemy ships
			EnemyShip.killAll();
			//destroy all aliens
			Alien.killAll();
			
			//tally points
			gameOverMenu.points.text = points;
			
			if(shots>0)
			{
				h = Math.floor((hits/shots) * 100);
			}
			else
			{
				h = 0;
			}
			
			if(aliensCaptured == 0)
			{
				ac = 0;
			}
			else
			{
				ac = aliensCaptured * 100;				
			}
			
			//If using the Kongregate API, submit kills tally
			//kongregate.stats.submit( "KillsLife" , kills);
			
			//diplay point bounses
			gameOverMenu.bonus.text = "hit%: " + h + "  x  kills: " + kills + "\n  +  aliens captured: " + aliensCaptured + " (x 100)";
			
			points =  points + ((h * kills) + ac);
			gameOverMenu.total.text = points;
			scoreText.text = String(points);

			//If using the Kongregate API, submit score
			//kongregate.scores.submit( points, difficultyMode);	
		}
	}
	
}