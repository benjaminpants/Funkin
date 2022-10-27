function new(x,y,character,isActPlayer)
{
	var tex = Paths.getSparrowAtlas('Pico_FNF_assetss');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('idle', "Pico Idle Dance", 24);
	this.myChar.animation.addByPrefix('singUP', 'pico Up note0', 24, false);
	this.myChar.animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
	if (this.isPlayer)
	{
		this.myChar.animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
		this.myChar.animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
		this.myChar.animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
		this.myChar.animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
	}
	else
	{
		// Need to be flipped! REDO THIS LATER!
		this.myChar.animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
		this.myChar.animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
		this.myChar.animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
		this.myChar.animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
	}

	this.myChar.animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
	this.myChar.animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

	this.addOffset('idle');
	this.addOffset("singUP", -29, 27);
	this.addOffset("singRIGHT", -68, -7);
	this.addOffset("singLEFT", 65, 9);
	this.addOffset("singDOWN", 200, -70);
	this.addOffset("singUPmiss", -19, 67);
	this.addOffset("singRIGHTmiss", -60, 41);
	this.addOffset("singLEFTmiss", 62, 64);
	this.addOffset("singDOWNmiss", 210, -28);

	this.playAnim('idle');

	this.myChar.flipX = true;
	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}