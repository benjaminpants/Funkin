function new(x,y,character,isActPlayer)
{
	// DAD ANIMATION LOADING CODE
	var tex = Paths.getSparrowAtlas('spooky_kids_assets');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
	this.myChar.animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
	this.myChar.animation.addByPrefix('singLEFT', 'note sing left', 24, false);
	this.myChar.animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
	this.myChar.animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
	this.myChar.animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

	this.addOffset('danceLeft');
	this.addOffset('danceRight');

	this.addOffset("singUP", -20, 26);
	this.addOffset("singRIGHT", -130, -14);
	this.addOffset("singLEFT", 130, -10);
	this.addOffset("singDOWN", -50, -130);

	this.playAnim('danceRight');
	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}

function dance()
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