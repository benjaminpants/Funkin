package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxG;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var noteType:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public var MyStrum:FlxSprite;

	private var InPlayState:Bool = false;

	private var InPixelStage:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;


	public function ScanForViableStrum(musthit:Bool)
	{
		var state:PlayState = cast(FlxG.state,PlayState);
			InPlayState = true;
			if (musthit)
			{
				state.playerStrums.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == (noteData % 4))
					{
						x = spr.x;
						MyStrum = spr;
					}
				});
			}
			else
			{
				state.dadStrums.forEach(function(spr:FlxSprite)
					{
						if (spr.ID == (noteData % 4))
						{
							x = spr.x;
							MyStrum = spr;
						}
					});
			}
	}


	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?notetype:Int = 0, ?musthit:Bool = false)
	{
		visible = false;
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;

		this.noteData = noteData;

		var daStage:String = PlayState.curStage;

		noteType = notetype;

		if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
		{
			InPlayState = true;
			ScanForViableStrum(musthit);
		}

		Config.NoteTypes[noteType].InitializeVisuals(this,noteData,isSustainNote,0,daStage,prevNote,!InPlayState);

		InPixelStage = Config.PixelStages.contains(PlayState.SONG.song.toLowerCase());
		visible = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (MyStrum != null)
		{
			x = MyStrum.x + (isSustainNote ? (InPixelStage ? width - (width / 3) : width + (width / 9)) : 0);
		}
		else
		{
			if (InPlayState)
			{
				ScanForViableStrum(mustPress);
			}
		}
		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
