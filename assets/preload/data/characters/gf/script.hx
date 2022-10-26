function new(x,y,character,isActPlayer)
{
	// GIRLFRIEND CODE
	var tex = Paths.getSparrowAtlas('GF_assets');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('cheer', 'GF Cheer', 24, false);
	this.myChar.animation.addByPrefix('singLEFT', 'GF left note', 24, false);
	this.myChar.animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
	this.myChar.animation.addByPrefix('singUP', 'GF Up Note', 24, false);
	this.myChar.animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
	this.myChar.animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
	this.myChar.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
	this.myChar.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	this.myChar.animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
	this.myChar.animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
	this.myChar.animation.addByPrefix('scared', 'GF FEAR', 24);

	this.addOffset('cheer');
	this.addOffset('sad', -2, -2);
	this.addOffset('danceLeft', 0, -9);
	this.addOffset('danceRight', 0, -9);

	this.addOffset("singUP", 0, 4);
	this.addOffset("singRIGHT", 0, -20);
	this.addOffset("singLEFT", 0, -19);
	this.addOffset("singDOWN", 0, -20);
	this.addOffset('hairBlow', 45, -8);
	this.addOffset('hairFall', 0, -9);

	this.addOffset('scared', -2, -17);

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