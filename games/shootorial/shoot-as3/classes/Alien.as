/*
The Alien class creates controls the falling alien movie clips when enemy ships are destroyed.
*/
package
{
	import flash.display.*
	import flash.events.*
	
	public class Alien extends MovieClip
	{
		//the list is an array of all aliens on stage
		static public var list:Array= [];
		
		//the aliens can be in one of two modes: falling and running
		public var mode:String;
		
		//each mode has its own speed
		public var runSpeed:int;
		public var fallSpeed:int;
		
		
		public function Alien(x_, y_)
		{
			//add a sound for the falling alien
			var s = new SoundAlienFall();
			s.play();
			
			//add this alien to the list of aliens
			list.push(this);
			//update a stat that counts aliens created
			Game.main.updateStat("aliensEjected",1);
			
			//aliens start by falling from their ship
			mode = "falling";
			
			//set the speeds for running and falling
			runSpeed = 5;
			fallSpeed = 1;
			
			//we pass in the x and y position of the alien when it's created. This is the position of the ship
			//that it ejected from
			x = x_;
			y = y_;
			
			//we want to control the alien's movement logic at frame rate using an ENTER_FRAME event
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		//this logic will happen at frame rate
		public function enterFrame(e:Event)
		{
			//if the alien is falling
			if(mode == "falling")
			{
				//update its y position
				y+=fallSpeed;
				//increase it's velocity
				fallSpeed += 1;
				//if it reaches the ground
				if(y >= 290)
				{
					//make sure it on the ground and not below it
					y = 290;
					//set its mode to running
					mode = "running";
				}
				
			}
			
			//if the alien is running
			if(mode == "running")
			{
				//update it x position, make it run to the left
				x -= runSpeed;
				//if it reaches the left edge of the screen
				if( x< 0)
				{
					//kill it
					kill();
				}
			}
			
			//do a collision check with the hero ship
			if(this.hitTestObject(Game.main.ship.hitRect))
			{
				//if the hero ship hits the alien make a capture sound
				var s = new SoundBling();
				s.play();
				
				var pointD;
				
				//if the alien was running when captured
				if(mode == "running")
				{
					//update points by 100
					Game.main.updateStat("points",100);
					// make a little floating point display
					pointD = new PointDisplay(x,y-20,100, 1);
					//display the point display on stage
					Game.main.spriteClip.addChild(pointD);
					
				}
				//if the alien was falling when captured
				else if(mode == "falling")
				{
					//update the points by 1000! 
					Game.main.updateStat("points",1000);
					//update the stat for captured-in-the-air
					Game.main.updateStat("aliensCapturedInAir",1);
					// make a little floating point display
					pointD = new PointDisplay(x,y-20,1000, 2);
					//display it on stage
					Game.main.spriteClip.addChild(pointD);	
				}
				//after capturing the alien, kill it (remove it from stage)
				kill();
				//update a game stat that counts aliens captured
				Game.main.updateStat("aliensCaptured",1);
				//show a running tally of aliens captured
				Game.main.alienCounter.visible = true;
				//update the text on that tally
				Game.main.alienCounter.aliensCaptured.text = Game.main.aliensCaptured;
			}
		}
		
		//this method will destory all aliens in the alien list
		static public function killAll()
		{
			//keep killing the fisrt alien in the list until the list is empty
			while(list.length>0)
			{
				list[0].kill();
			}
		}
		
		//this method will kill this alien instance
		public function kill()
		{
			//cycle through the alien list
			for(var i:int = 0;i < list.length; i++)
			{
				//if this list index is me
				if(list[i] == this)
				{
					// remove me form the alien list
					list.splice(i,1);
				}
			}
			//remove my ENTER_FRAME event
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			//remove my grpahic from the stage
			Game.main.spriteClip.removeChild(this);
		}
	}
}