﻿/*The EnemyMissile class is linked to an EnemyMissile movie clip in the library that will get attached to stage when enemy ships fire.*/class EnemyMissile extends MovieClip{		//We want to create a couple of varibles to keep track of important EnemyMissile information. 	//We must define them here		//This will store how fast the enemy missile travels	var speed;		//Minibosses and the Boss can shoot diagonally. This variable keeps track of positive and negative vertical movement of te missile	var yDirection;	//This onLoad function is a built-in function of every movie clip. 	//When an enemy missile is first loaded onto stage (it will get attached to the stage from the library) we want to:	function onLoad()	{		//Set it's speed to -15 (we want it to move 15 pixels in the negative x direction (left) at frame rate)		speed = -15;	}			//This onEnterFrame function is a built-in function of every movie clip. 	//All the code that we need to continuously execute at 30 frames a second goes inside this function	function onEnterFrame()	{		// --- HORIZONTAL MOVEMENT LOGIC---		//move the enemy missile left 15 pixels (we set it's speed to -15 in the onLoad() function)		_x += speed;				// --- VERTICAL MOVEMENT LOGIC---		//If this missile has a y Direction (set in the MiniBoss and Boss classes when a missile is fired)		if(yDirection)		{			//move the missile up or down (multiply this value to get various degreesof travel. 4 looked good in this game)			_y += yDirection * 4;		}				// --- COLLISION LOGIC---		//If this missile is hitting the hero ship AND ( && ) the hero ship's shield is NOT activated		if(this.hitTest( _root.ship) && _root.ship.shield._visible == false)		{			//remove this missile from stage			this.removeMovieClip();			//subtract 10 from the ship's health			_root.ship.updateHealth(-10);			//start the ship shaking to reflect that it's taking damage			_root.ship.initShake();			//create a small explosion to reflect that the ship is taking damage			var explosion = _root.attachMovie("SmallExplosion","SmallExplosion" + _root.getNextHighestDepth(),_root.getNextHighestDepth());			//position the explosion at the ship's location on stage			explosion._x = _root.ship._x;			explosion._y = _root.ship._y;		}				//If this enemy missile has reached the left edge of the screen, just remove it.		if(_x < 0)		{			this.removeMovieClip();		}	}}