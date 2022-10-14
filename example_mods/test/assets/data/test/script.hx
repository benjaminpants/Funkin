import flixel.tweens.FlxTween;


var ps = PlayState.thisState;

var funny = 0.5;

function create()
{
	trace("yipee");
}

function update(elapsed)
{
	ps.boyfriend.y -= Math.sin(ps.elapsedTime);
	
	if (FlxG.keys.justPressed.ZERO)
	{
		fart = fart + 1; //crash the game on purpose.
	}
}

function beatHit()
{
	if (ps.curBeat % 4)
	{
		ps.defaultCamZoom += funny;
		funny *= -1;
	}
}

function stepHit()
{
	ps.gf.playAnim("cheer",true);
}


function songStarted()
{
	ps.camZooming = true;
	ps.dadStrums.forEach(function(strum:StrumNote)
	{
		var centerx = (FlxG.width / 2) - (strum.width / 2);
		var centery = (FlxG.height / 2) - (strum.height / 2);
		FlxTween.tween(strum, {x: centerx, y: centery, alpha: 0.2, noteAngle: strum.ID * 90}, 64, {ease: FlxEase.cubeInOut});
	});
	ps.playerStrums.forEach(function(strum:StrumNote)
	{
		var centerx = (FlxG.width / 2) - (strum.width / 2);
		var centery = (FlxG.height / 2) - (strum.height / 2);
		FlxTween.tween(strum, {x: centerx, y: centery, noteAngle: strum.ID * 90}, 64, {ease: FlxEase.cubeInOut});
	});
}