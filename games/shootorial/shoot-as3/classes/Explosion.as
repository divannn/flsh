﻿/*The Explosion class controls all explosions*/package{	import flash.display.*	import flash.events.*		public class Explosion extends MovieClip	{		//pass the position of the explosion in (it will be the position of whtever ship is being destroyed)		public function Explosion(x_, y_)		{			//set the explosion's x and y postion based on the values passed in 			x = x_;			y = y_;			//add an ENTER_FRAME event to do some logic at fram rate			addEventListener(Event.ENTER_FRAME, enterFrame);		}				//do this at frame rate		public function enterFrame(e:Event)		{			//The explosion is just a movie clip with many frames, each frame just see if it's reached it final frame 			if(currentFrame == totalFrames)			{				//if so, remove it's ENTER_FRAME event and remove it from stage, it's work is done				removeEventListener(Event.ENTER_FRAME, enterFrame);				Game.main.spriteClip.removeChild(this);			}		}	}}