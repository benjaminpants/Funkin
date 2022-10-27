package;

import Config.CharacterMetadata;
import flixel.math.FlxPoint;
import haxe.Log;
import lime.system.System;
import flixel.system.debug.log.Log;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

import flixel.addons.effects.FlxTrail;

using Character;

using StringTools;

class ScriptableSpriteCharacter extends ScriptableCharacter
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public var myChar:FlxSprite;

	public var myMetadata:CharacterMetadata;

	public var singHoldTime:Float = 4;

	public override function get_currentAnim() 
	{
		if (myChar.animation.curAnim == null)
		{
			return "";
		}
		return myChar.animation.curAnim.name;
	}

	public override function animationExists(animationToCheck:String):Bool
	{
		return animOffsets.exists(animationToCheck);
	}

	public override function getGraphicMidpoint(?point:FlxPoint):FlxPoint {
		return myChar.getGraphicMidpoint();
	}

	public override function getMidpoint(?point:FlxPoint):FlxPoint {
		return myChar.getMidpoint(point);
	}

	public function new(x:Float, y:Float, ?character:String = "bf", ?isActPlayer:Bool = false)
	{

		animOffsets = new Map<String, Array<Dynamic>>();

		myMetadata = Config.Characters.filter(f -> f.name == character)[0]; //its very bad to assume the man exists but we gotta

		trace(myMetadata); //what the fuck.

		myChar = new FlxSprite();

		super(x, y, character, isActPlayer);

		dance();

		if (isPlayer)
		{
			myChar.flipX = !myChar.flipX;

			if (myChar.animation.curAnim == null)
			{
				return;
			}

			// Doesn't flip for BF, since his are already in the right place???
			if (!myMetadata.nativePlayer)
			{
				// var animArray
				var oldrightsets = animOffsets['singRIGHT'];

				var oldRight = myChar.animation.getByName('singRIGHT').frames;
				myChar.animation.getByName('singRIGHT').frames = myChar.animation.getByName('singLEFT').frames;
				animOffsets['singRIGHT'] = animOffsets['singLEFT'];
				myChar.animation.getByName('singLEFT').frames = oldRight;
				animOffsets['singLEFT'] = oldrightsets;

				// IF THEY HAVE MISS ANIMATIONS??
				if (myChar.animation.getByName('singRIGHTmiss') != null)
				{
					var oldmisssets = animOffsets['singRIGHTmiss'];
					var oldMiss = myChar.animation.getByName('singRIGHTmiss').frames;
					myChar.animation.getByName('singRIGHTmiss').frames = myChar.animation.getByName('singLEFTmiss').frames;
					animOffsets['singRIGHTmiss'] = animOffsets['singLEFTmiss'];
					myChar.animation.getByName('singLEFTmiss').frames = oldMiss;
					animOffsets['singLEFTmiss'] = oldmisssets;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if ((!debugMode) && isPlayer)
		{
			if (currentAnim.startsWith('sing'))
			{
				holdTimer += elapsed;
			}
			else
				holdTimer = 0;

			if (myChar.animation.curAnim == null) return;

			if (myChar.animation.curAnim.name.endsWith('miss') && myChar.animation.curAnim.finished && !debugMode)
			{
				playAnim('idle', true, false, 10);
			}

			if (myChar.animation.curAnim.name == 'firstDeath' && myChar.animation.curAnim.finished)
			{
				playAnim('deathLoop');
			}
		}

		if (myChar.animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}

		if (!myMetadata.nativePlayer)
		{
			if (myChar.animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			//if (curCharacter == 'dad')
				//dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * singHoldTime * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		super.update(elapsed);
	}

	/**
	 * FOR GF DANCING SHIT
	 */
	public override function dance()
	{
		if (!debugMode)
		{
			if (script.hscriptInterp.variables.get("dance") == null)
			{
				playAnim("idle");
			}
			super.dance();
		}
	}

	public override function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Bool
	{
		if (myChar.animation.getByName(AnimName) == null)
		{
			trace(curCharacter + " is missing animation: \"" + AnimName + "\"");
			return false; //if the animation doesn't exist dont try to play it dumby
		}
		myChar.animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			myChar.offset.set(daOffset[0], daOffset[1]);
		}
		else
			myChar.offset.set(0, 0);

		super.playAnim(AnimName, Force, Reversed, Frame);
		return true;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
