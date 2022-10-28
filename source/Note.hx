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
	private var script:Script;
	public var noteData:Int = 0;
	public var noteType:String = "n";
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var wasBadHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public var MyStrum:StrumNote;

	private var InPlayState:Bool = false;

	private var InPixelStage:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var alphaMult:Float = 1.0;
	public var noteOffset:Float = 0;


	public function ScanForViableStrum(musthit:Bool)
	{
		var state:PlayState = cast(FlxG.state,PlayState);
		InPlayState = true;
		if (musthit)
		{
			state.playerStrums.forEach(function(spr:StrumNote)
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
			state.dadStrums.forEach(function(spr:StrumNote)
				{
					if (spr.ID == (noteData % 4))
					{
						x = spr.x;
						MyStrum = spr;
					}
				});
		}
		if (MyStrum != null)
		{
			GoToStrum(MyStrum);
		}
	}

	public function GoToStrum(strum:StrumNote)
	{
		//x = strum.x + noteOffset;
		angle = isSustainNote ? strum.noteAngle : strum.noteVisualAngle; //handle this here for now
		alpha = strum.alpha * alphaMult;
	}


	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?notetype:String = "", ?musthit:Bool = false, ?script:Script)
	{
		visible = false;
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 5000;
		this.strumTime = strumTime;

		this.noteData = noteData;

		this.script = script;

		if (notetype != null)
		{
			noteType = notetype;
		}

		var daStage:String = PlayState.curStage;

		if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
		{
			InPlayState = true;
			ScanForViableStrum(musthit);
		}

		initializeVisuals();
		//Config.NoteTypes[noteType].InitializeVisuals(this,noteData,isSustainNote,0,daStage,prevNote,!InPlayState);

		InPixelStage = Config.PixelStages.contains(PlayState.SONG.song.toLowerCase());
		visible = true;

		script.CallFunction("create",[this]);
	}

	public function initializeVisuals()
	{
		if (script.CallFunction("initializeVisuals",[this]) != true) return; //placeholder
		var swagWidth:Float = 160 * 0.7;
		var daStyle:String = "not the school";

        switch (daStyle)
		{
			case 'school' | 'schoolEvil':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);

				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));

				updateHitbox();

				if (isSustainNote)
				{
					noteOffset = (width * 0.75);
				}

			default:
				frames = Paths.getSparrowAtlas('NOTE_assets');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;

				if (isSustainNote)
				{
					noteOffset = width / 3;
				}
		}

		switch (noteData)
		{
			case 0:
				animation.play('purpleScroll');
			case 1:
				animation.play('blueScroll');
			case 2:
				animation.play('greenScroll');
			case 3:
				animation.play('redScroll');
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			alphaMult = 0.6;

			if (FlxG.save.data.downscroll) //flip the trail on the last note so it looks right
				{
					flipY = true;
				}

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
    }

	public function onHit():Bool
	{
		return script.CallFunction("onHit",[this]);
	}
	public function onMiss():Bool
	{
		return script.CallFunction("onMiss",[this]);
	}
	public function calculateScrollSpeed(currentSpeed:Float):Float
	{
		return script.CallFunction("calculateScrollSpeed",[this,currentSpeed]);
	}
	public function shouldOpponentHit():Bool
	{
		return script.CallFunction("shouldOpponentHit",[this]);
	}

	public function onOpponentHit()
	{
		return script.CallFunction("onOpponentHit",[this]);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (MyStrum != null)
		{
			//x = MyStrum.x + (isSustainNote ? (InPixelStage ? width - (width / 3) : width + (width / 9)) : 0);
			GoToStrum(MyStrum);
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

		script.CallFunction("update",[this]);
	}
}
