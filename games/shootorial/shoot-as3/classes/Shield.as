/*
This class displays a shield powerup
*/

package
{
	import flash.display.*
	import flash.events.*
	
	public class Shield extends MovieClip
	{
		//when a shield is created
		public function Shield()
		{
			//add an ENTER_FRAME event so we can do some logic at frame rate
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		//do this at frame rate
		public function enterFrame(e:Event)
		{
			//have the shield slowly fade over time
			alpha -= .002;
			//if it has faded all the way, kill it
			if(alpha <= .1)
			{
				kill();
				
			}
		}
		
		//when the shield is killed
		public function kill()
		{
			//remove its ENTER_FRAME event
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			//remove the graphic from the ship
			Ship.main.removeChild(this);
			//set the ship's shield property to null
			Ship.main.shield = null;
		}
		
		
	}
}