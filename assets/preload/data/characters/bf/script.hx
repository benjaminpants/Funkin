function new(x,y,character,isActPlayer)
{
	var tex = Paths.getSparrowAtlas('BOYFRIEND');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('idle', 'BF idle dance', 24, false);
	this.myChar.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
	this.myChar.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
	this.myChar.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
	this.myChar.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
	this.myChar.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
	this.myChar.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
	this.myChar.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
	this.myChar.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
	this.myChar.animation.addByPrefix('hey', 'BF HEY', 24, false);

	this.myChar.animation.addByPrefix('firstDeath', "BF dies", 24, false);
	this.myChar.animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
	this.myChar.animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

	this.myChar.animation.addByPrefix('scared', 'BF idle shaking', 24);

	this.addOffset('idle', -5);
	this.addOffset("singUP", -29, 27);
	this.addOffset("singRIGHT", -38, -7);
	this.addOffset("singLEFT", 12, -6);
	this.addOffset("singDOWN", -10, -50);
	this.addOffset("singUPmiss", -29, 27);
	this.addOffset("singRIGHTmiss", -30, 21);
	this.addOffset("singLEFTmiss", 12, 24);
	this.addOffset("singDOWNmiss", -11, -19);
	this.addOffset("hey", 7, 4);
	this.addOffset('firstDeath', 37, 11);
	this.addOffset('deathLoop', 37, 5);
	this.addOffset('deathConfirm', 37, 69);
	this.addOffset('scared', -4);

	this.playAnim('idle');

	this.myChar.flipX = true;
	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}