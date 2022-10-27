function new(x,y,character,isActPlayer)
{
	var tex = Paths.getSparrowAtlas('Monster_Assets');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('idle', 'monster idle', 24, false);
	this.myChar.animation.addByPrefix('singUP', 'monster up note', 24, false);
	this.myChar.animation.addByPrefix('singDOWN', 'monster down', 24, false);
	this.myChar.animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
	this.myChar.animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

	this.addOffset('idle');
	this.addOffset("singUP", -20, 50);
	this.addOffset("singRIGHT", -51);
	this.addOffset("singLEFT", -30);
	this.addOffset("singDOWN", -30, -40);
	this.playAnim('idle');

	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}