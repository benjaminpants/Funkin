

var ps = PlayState.thisState;

var halloweenBG;

var lightningStrikeBeat = 0;
var lightningOffset = 8;

function create()
{
	var hallowTex = Paths.getSparrowAtlas('halloween_bg');

	halloweenBG = new FlxSprite(-200, -75);
	halloweenBG.frames = hallowTex;
	halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
	halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
	halloweenBG.animation.play('idle');
	halloweenBG.antialiasing = true;
	ps.add(halloweenBG);

}

function beatHit()
{
	if (FlxG.random.bool(10) && ps.curBeat > lightningStrikeBeat + lightningOffset)
	{
		lightningStrikeShit();
	}
}

function lightningStrikeShit()
{
	FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
	halloweenBG.animation.play('lightning');

	lightningStrikeBeat = ps.curBeat;
	lightningOffset = FlxG.random.int(8, 24);

	ps.boyfriend.playAnim('scared', true);
	ps.gf.playAnim('scared', true);
}