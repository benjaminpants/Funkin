package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

using StringTools;

class Boyfriend extends SpriteCharacter
{
	public var stunned:Bool = false;

	public function new(x:Float, y:Float, ?char:String = 'bf')
	{
		super(x, y, char, true);
	}

	override function update(elapsed:Float)
	{
		if (!debugMode)
		{
			if (myChar.animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}
			else
				holdTimer = 0;

			if (myChar.animation.curAnim.name.endsWith('miss') && myChar.animation.curAnim.finished && !debugMode)
			{
				playAnim('idle', true, false, 10);
			}

			if (myChar.animation.curAnim.name == 'firstDeath' && myChar.animation.curAnim.finished)
			{
				playAnim('deathLoop');
			}
		}

		super.update(elapsed);
	}
}
