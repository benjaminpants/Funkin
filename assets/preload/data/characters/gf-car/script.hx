function new(x,y,character,isActPlayer)
{
	// GIRLFRIEND CODE
	var tex = Paths.getSparrowAtlas('gfCar');
	this.myChar.frames = tex;
	this.myChar.animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
	this.myChar.animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
	this.myChar.animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

	this.addOffset('danceLeft', 0);
	this.addOffset('danceRight', 0);

	this.playAnim('danceRight');
	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}

function playAnim(AnimName, Force, Reversed, Frame)
{
	if (AnimName == 'singLEFT')
	{
		this.danced = true;
	}
	else if (AnimName == 'singRIGHT')
	{
		this.danced = false;
	}

	if (AnimName == 'singUP' || AnimName == 'singDOWN')
	{
		this.danced = !this.danced;
	}
}

function dance()
{
	//damn it
	
	if (!StringTools.startsWith(this.currentAnim,"hair"))
	{
		this.danced = !this.danced;

		if (this.danced)
		{
			this.playAnim('danceRight');
		}
		else
		{
			this.playAnim('danceLeft');
		}
	}
	
}