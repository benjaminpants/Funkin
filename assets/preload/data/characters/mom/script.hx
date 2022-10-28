function new(x,y,character,isActPlayer)
{
	var tex = Paths.getSparrowAtlas(character == 'mom-car' ? 'momCar' : 'Mom_Assets');
	this.myChar.frames = tex;

	this.myChar.animation.addByPrefix('idle', "Mom Idle", 24, false);
	this.myChar.animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
	this.myChar.animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
	this.myChar.animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
	// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
	// CUZ DAVE IS DUMB!
	this.myChar.animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

	this.addOffset('idle');
	this.addOffset("singUP", 14, 71);
	this.addOffset("singRIGHT", 10, -60);
	this.addOffset("singLEFT", 250, -23);
	this.addOffset("singDOWN", 20, -160);

	this.playAnim('idle');

	
	this.myChar.antialiasing = true;
	
	this.add(this.myChar);
}