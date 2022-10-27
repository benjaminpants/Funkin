package;

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

//there are some bugs with flipX here but im obsoleting this class anyway so...

class SpriteCharacter extends Character
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public var myChar:FlxSprite;

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
		super(x, y, character, isActPlayer);

		animOffsets = new Map<String, Array<Dynamic>>();

		myChar = new FlxSprite();

		add(myChar);

		var tex:FlxAtlasFrames;
		myChar.antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				myChar.frames = tex;
				myChar.animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				myChar.animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				myChar.animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				myChar.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				myChar.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				myChar.animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				myChar.animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				myChar.animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('christmas/gfChristmas');
				myChar.frames = tex;
				myChar.animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				myChar.animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				myChar.animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				myChar.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				myChar.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				myChar.animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				myChar.animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				myChar.animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('gfCar');
				myChar.frames = tex;
				myChar.animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				myChar.animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				myChar.animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('weeb/gfPixel');
				myChar.frames = tex;
				myChar.animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				myChar.animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				myChar.animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				myChar.setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				myChar.updateHitbox();
				myChar.antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'Dad idle dance', 24);
				myChar.animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				myChar.animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				myChar.animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				myChar.animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('spooky_kids_assets');
				myChar.frames = tex;
				myChar.animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				myChar.animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				myChar.animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('Mom_Assets');
				myChar.frames = tex;

				myChar.animation.addByPrefix('idle', "Mom Idle", 24, false);
				myChar.animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				myChar.animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				myChar.animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('momCar');
				myChar.frames = tex;

				myChar.animation.addByPrefix('idle', "Mom Idle", 24, false);
				myChar.animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				myChar.animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				myChar.animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('Monster_Assets');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'monster idle', 24, false);
				myChar.animation.addByPrefix('singUP', 'monster up note', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'monster down', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('christmas/monsterChristmas');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'monster idle', 24, false);
				myChar.animation.addByPrefix('singUP', 'monster up note', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'monster down', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('Pico_FNF_assetss');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', "Pico Idle Dance", 24);
				myChar.animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					myChar.animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					myChar.animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					myChar.animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					myChar.animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					myChar.animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					myChar.animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					myChar.animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					myChar.animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				myChar.animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				myChar.animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'BF idle dance', 24, false);
				myChar.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				myChar.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				myChar.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				myChar.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				myChar.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				myChar.animation.addByPrefix('hey', 'BF HEY', 24, false);

				myChar.animation.addByPrefix('firstDeath', "BF dies", 24, false);
				myChar.animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				myChar.animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				myChar.animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('christmas/bfChristmas');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'BF idle dance', 24, false);
				myChar.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				myChar.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				myChar.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				myChar.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				myChar.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				myChar.animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar');
				myChar.frames = tex;
				myChar.animation.addByPrefix('idle', 'BF idle dance', 24, false);
				myChar.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				myChar.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				myChar.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				myChar.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				myChar.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				myChar.frames = Paths.getSparrowAtlas('weeb/bfPixel');
				myChar.animation.addByPrefix('idle', 'BF IDLE', 24, false);
				myChar.animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				myChar.animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				myChar.animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				myChar.animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				myChar.animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				myChar.setGraphicSize(Std.int(width * 6));
				myChar.updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				myChar.antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				myChar.frames = Paths.getSparrowAtlas('weeb/bfPixelsDEAD');
				myChar.animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				myChar.animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				myChar.animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				myChar.animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				myChar.animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				myChar.setGraphicSize(Std.int(width * 6));
				myChar.updateHitbox();
				myChar.antialiasing = false;
				flipX = true;

			case 'senpai':
				myChar.frames = Paths.getSparrowAtlas('weeb/senpai');
				myChar.animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				myChar.animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				myChar.setGraphicSize(Std.int(width * 6));
				myChar.updateHitbox();

				myChar.antialiasing = false;
			case 'senpai-angry':
				myChar.frames = Paths.getSparrowAtlas('weeb/senpai');
				myChar.animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				myChar.animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				myChar.setGraphicSize(Std.int(width * 6));
				myChar.updateHitbox();

				myChar.antialiasing = false;

			case 'spirit':
				myChar.frames = Paths.getPackerAtlas('weeb/spirit');
				myChar.animation.addByPrefix('idle', "idle spirit_", 24, false);
				myChar.animation.addByPrefix('singUP', "up_", 24, false);
				myChar.animation.addByPrefix('singRIGHT', "right_", 24, false);
				myChar.animation.addByPrefix('singLEFT', "left_", 24, false);
				myChar.animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				myChar.setGraphicSize(Std.int(width * 6));
				myChar.updateHitbox();

				myChar.antialiasing = false;

				var evilTrail = new FlxTrail(myChar, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				//spaghetti.
				remove(myChar);
				add(evilTrail);
				add(myChar);

				playAnim('idle');
				// evilTrail.scrollFactor.set(1.1, 1.1);

			case 'parents-christmas':
				myChar.frames = Paths.getSparrowAtlas('christmas/mom_dad_christmas_assets');
				myChar.animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				myChar.animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				myChar.animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				myChar.animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				myChar.animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				myChar.animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				myChar.animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				myChar.animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				myChar.animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			if (myChar.animation.curAnim == null)
			{
				return;
			}

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
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

		if (myChar.animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}

		if (!curCharacter.startsWith('bf'))
		{
			if (myChar.animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (myChar.animation.curAnim.name == 'hairFall' && myChar.animation.curAnim.finished)
					playAnim('danceRight');
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
			switch (curCharacter)
			{
				case 'gf':
					if (!myChar.animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!myChar.animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!myChar.animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!myChar.animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
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

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
		return true;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
