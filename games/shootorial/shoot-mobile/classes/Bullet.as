/*
This class draws bullets, moves them across stage, and checks to see if they hit any enemies
*/

package
{
	import flash.display.*
	import flash.events.*
	import flash.filters.BitmapFilter;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.GlowFilter;
	import flash.media.SoundTransform;

	public class Bullet extends Sprite
	{
		//the bullets will have a speed
		public var speed:int;
		private static var numBullets:uint = 0;
		
		public function Bullet(x_, y_)
		{
			//make a sound when a bullet is fired
			numBullets++;
			if(numBullets % 2 == 0){
			  var transform:SoundTransform = new SoundTransform(0.1);
			  var s = new Shot2();
  			s.play(0,0,transform);
			}
			
			//set the bullet speed
			speed = 20;
			//set the bullet position based on x and y values passed in (it needs to be created at the hero ship's position)
			x = x_;
			y = y_;
			
			//draw a bullet using the drawing API
			//start with a fat black line
			graphics.lineStyle(7,0x000000,1);
			graphics.moveTo(-2,0);
			graphics.lineTo(2,0);
			//then draw a thinner white line on top of it
			graphics.lineStyle(3,0xffffff,1);
			graphics.moveTo(-2,0);
			graphics.lineTo(2,0);
			//add an ENTER_FRAME event to control the bullet's logic at frame rate
			FrameTimer.add(this);
			//this improves perfromance of vector graphics
			//this.filters = [getGlowFilter()];
			cacheAsBitmap = true;
		}
		
		private function getGlowFilter():BitmapFilter {
      var color:Number = 0x00FF00;
      var alpha:Number = 0.70;
      var blurX:Number = 6;
      var blurY:Number = 6;
      var strength:Number = 2;
      var inner:Boolean = false;
      var knockout:Boolean = false;
      var quality:Number = BitmapFilterQuality.LOW;

      return new GlowFilter(color,
                            alpha,
                            blurX,
                            blurY,
                            strength,
                            quality,
                            inner,
                            knockout);
    }
    
		
		//this logic will happen at frame rate
		public function enterFrame(e:Event)
		{
			//move the bullet to the right
			x += speed;
			//if it reaches the right edge of the screen
			if(x > Game.WIDTH)
			{
				//kil it
				 kill();
				//add to the miss count
				Game.main.updateStat("misses",1);
				 return;
			}

			//iterate through the enemy ship list, and see if this bullet is hitting any enemies
			for(var i:int=0; i<EnemyShip.list.length; i++)
			{
				//if this bullet is hitting this enemy in the list
				if(this.hitTestObject(EnemyShip.list[i].hitRect))
				{
					//have the hit enemy take damage
					EnemyShip.list[i].takeDamage(1);
					//kill the bullet
					kill();
					
					break;
				}
			}
			
		}
		
		//on kill, just remove the bullets ENTER_FRAME event and its graphic
		public function kill()
		{
			FrameTimer.remove(this);
			Game.main.spriteClip.removeChild(this);
		}
		
	}
	
}