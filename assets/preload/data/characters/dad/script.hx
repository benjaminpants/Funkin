function new(x,y,character,isActPlayer)
{
	// DAD ANIMATION LOADING CODE
	var tex = Paths.getSparrowAtlas('DADDY_DEAREST');
	this.myChar.frames = tex;
	this.myChar.animation.addByPrefix('idle', 'Dad idle dance', 24);
	this.myChar.animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
	this.myChar.animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
	this.myChar.animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
	this.myChar.animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

	this.addOffset('idle');
	this.addOffset("singUP", -6, 50);
	this.addOffset("singRIGHT", 0, 27);
	this.addOffset("singLEFT", -10, 10);
	this.addOffset("singDOWN", 0, -30);

	this.playAnim('idle');
	
	this.singHoldTime = 6.1;

	this.flipX = true;
	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}