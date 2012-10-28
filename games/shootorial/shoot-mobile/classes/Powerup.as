/*
The PowerUp class will create a powerup at an interval defined in the LevelManager (every 10 seconds)
*/

package
{
	import flash.display.*
	import flash.events.*
	import flash.filters.BitmapFilter;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.GlowFilter;
	
	public class Powerup extends MovieClip
	{
		//each power up will have an x velocity and a y velocity
		public var xv:Number;
		public var yv:Number;
		//each power up will randomly decide when it's created what kind it is: SHIELD, NUKE, or HEALTH
		public var powerType:String;
		
		public function Powerup()
		{
			//when a powe up is created (from the powerup timer in the level manager) position it to the right of the stage
			x = Game.WIDTH + 50;
			//position it at a random height
			y = Math.floor(Math.random()*(Game.HEIGHT-50)+25);
			//add an ENTER_FRAME event so we can do some logic at frame rate
			FrameTimer.add(this);
			this.filters = [getGlowFilter()];
			//set its x velocity
			xv = 2;
			//now have it decide what type of power up it's going to be
			definePowerType();
		}
		
		//this method will randomly decide what type of power up it's going to be
		public function definePowerType()
		{
			//first get a rnadom number between 1 and 10
			var ranType = Math.floor(Math.random()*10 + 1);
			//if it less than 4, make a shield
			if(ranType < 4)
				powerType = "shield";
			//or it it's less than 9 make a nuke
			else if(ranType < 9)
				powerType = "nuke";
			//otherwise make a health powerup
			else
				powerType = "health";
		}
		
		//do this at frame rate
		public function enterFrame(e:Event)
		{
			//rotate the graphic for fun
			rotation -= 2;
			//update its position, move it from right to left
			x -= xv;
			//if it's reached the left end of the stage, kill it			
			if(x < -50)
			{
				kill();
				return;
			}
			
			//if the heor ship is not dead
			if(Game.main.ship != null)
			{
				//if the hero ship hits this powerup
				if(this.hitTestObject(Game.main.ship.hitRect))
				{
					//award the power up to the ship
					awardPowerup();
					//show a point display with text that labels what powerup you've just gotten
					var d = new PointDisplay(x,y,powerType,1);
					//add that point display to stage
					Game.main.spriteClip.addChild(d);
					//kill this power up graphic
					kill();
				}
			}
		}
		
		//this method caries out the reward
		public function awardPowerup()
		{
			//if it's a shield
			if(powerType == "shield")
			{
				//make a shiled sound
				var s = new SoundShield();
				s.play();
				//make a new shiled
				Ship.main.shield = new Shield();
				//display the shield over the ship
				Ship.main.addChild(Ship.main.shield);
				
			}
			//if it's a nuke
			if(powerType == "nuke")
			{
				//create a new nuke
				new Nuke();
			}
			//if it's health
			if(powerType == "health")
			{
				//add 50 health
				Ship.main.health += 50;
				//if the new health is more than the ship's max health
				if(Ship.main.health > Ship.main.maxHealth)
				{
					//make the new health equal the max health
					Ship.main.health = Ship.main.maxHealth;
				}
				//update the ship's health meter
				Game.main.healthMeter.bar.scaleX = (Ship.main.health/Ship.main.maxHealth);
				
			}
		}
		
		//this method kills the powerup
		public function kill()
		{
			//remove the ENTER_FRAME event
			FrameTimer.remove(this);
			//remove the graphic
			Game.main.spriteClip.removeChild(this);
			
			//add a sound effect
			var s = new SoundPower();
			s.play();
			
		}
		
		private function getGlowFilter():BitmapFilter 
		{
      var color:Number = 0xFFE303;
      var alpha:Number = 0.70;
      var blurX:Number = 10;
      var blurY:Number = 10;
      var strength:Number = 4;
      var inner:Boolean = false;
      var knockout:Boolean = false;
      var quality:Number = BitmapFilterQuality.MEDIUM;

      return new GlowFilter(color,
                            alpha,
                            blurX,
                            blurY,
                            strength,
                            quality,
                            inner,
                            knockout);
    }
	}
}