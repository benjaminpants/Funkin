import flixel.tweens.FlxTween;


var ps = PlayState.thisState;




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