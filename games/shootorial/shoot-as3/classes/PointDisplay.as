/*
The PointDisplay class will display a floating point value at position on the stage associated with the awarding of points
*/

package
{
	import flash.display.*
	import flash.events.*
	import flash.text.*
	
	public class PointDisplay extends MovieClip
	{
		//how long the points will stay visible
		public var duration:int;
		//how fast the display will fade
		public var fadeSpeed:Number;
		//dictates whether its fading in or out
		public var fadeDir:int;
		
		public function PointDisplay(x_, y_, p_, d_)
		{
			//set the duration to the value passed in
			duration = d_ * 30; //frames per second
			//set a speed at which the display should fade
			fadeSpeed = 1/(.5 * duration);
			//it will start by fading in
			fadeDir = 1;
			//set the x and y position of the display based on what triggered the reward: killed enemy ship, captured alien, etc...
			x = x_;
			y = y_;
			//and an ENTER_FRAME event so we can do some logic at frame rate
			addEventListener(Event.ENTER_FRAME, enterFrame);
			//show the actual point value that gets passed in
			displayText.text = p_;
			//set the alpha of the display to 0 so it can start fading in
			alpha=0;
		}
		
		//do this logic at frame rate
		public function enterFrame(e:Event)
		{
			//increase the alpha by the fadeSpeed
			alpha += fadeSpeed * fadeDir;
			//if it fading in and reaches solid state
			if(fadeDir==1 && alpha>=1)
			{
				//reverse it's fade direction so it will start to fade out
				fadeDir *= -1;
			}
			//count down the duration of the display
			duration -= 1;
			//if the duration runs out, or the display is now totally transparent
			if(duration <= 0 || alpha <= 0)
			{
				//remove its ENTER_FRAME event and remove it from stage
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				Game.main.spriteClip.removeChild(this);
			}
		}
	}
}