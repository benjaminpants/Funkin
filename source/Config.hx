import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import haxe.Exception;
import NoteType;
import lime.system.System;
import flixel.system.debug.log.Log;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import DialogueCharacter;
import flixel.util.FlxColor;
import haxe.Json;
import lime.utils.Assets;
import hscript.Interp;
import hscript.Parser;
import flixel.FlxSprite;
import flixel.util.FlxTimer;


class Config
{
    //mod specific config settings will go here
    public static var Company:String = "ninjamuffin99";
    public static var Game:String = "funkin";

    public static var EngineVersion:String = "0.0(Not ready for use)";

    public static var PixelStages:Array<String> = [ "senpai", "roses", "thorns", "test" ];

    public static var DialogueCharacters:Map<String,DialogueCharacter> = [
        "bf-pixel" => new DialogueCharacter("weeb/bfPortrait",'Boyfriend portrait enter',false,"pixel_",1,true),
        "senpai" => new DialogueCharacter("weeb/senpaiPortrait",'Senpai Portrait Enter',true,"pixel_",1,true),
        "invisible" => new DialogueCharacter("nonePortrait",'Senpai Portrait Enter instance 1',true,"pixel_",1,true),
    ];

    public static var NoteTypes:Array<NoteTypeBase> = [
        new NoteTypeBase()
    ];








    //below is stuff that i probably shouldn't put in this object but i did anyway
    public static var Songs:Array<SongMetadata> = [];
    public static var Weeks:Array<WeekMetadata> = [];

    public static var MasterColors:Map<String,FlxColor> = new Map<String,FlxColor>();

    public static function LoadInitialData()
    {

        Paths.foundModsPath = Paths.getModDirectories();
        
        //load the master color scheme file
        var initColors = CoolUtil.coolTextFileWithMods(Paths.txt('masterColors'));

        
        for (i in 0...initColors.length)
        {
            var splitstring:Array<String> = initColors[i].split(":");
            splitstring = splitstring.filter(f -> f != "");
            MasterColors.set(splitstring[0],FlxColor.fromString(splitstring[1]));
        }

        //song list and weeks
        var initSonglist = CoolUtil.coolTextFileWithMods(Paths.txt('freeplaySonglist'));

		for (i in 0...initSonglist.length)
		{
			var splitstring:Array<String> = initSonglist[i].split(",");
			Songs.push(new SongMetadata(splitstring[0], Std.parseInt(splitstring[1]), splitstring[2],getDifficulties(splitstring[0])));
		}

        var initWeeklist = CoolUtil.coolTextFileWithMods(Paths.txt('weekList')); //todo: OBSOLETE THIS STUPID FILE!!!!!

        for (i in 0...initWeeklist.length)
        {
            var rawJson:String = Assets.getText(Paths.jsonMod('weeks/' + initWeeklist[i].toLowerCase()));
            var swagWeek:WeekMetadata = Json.parse(rawJson);
            trace("Adding:" + swagWeek.weekTitle);
            swagWeek.difficulties = new Array<Difficulty>(); //ignore anyones attempts to manually add in difficulties, and properly define the variable in the case they dont try breakign things.
            var songs:Array<SongMetadata> = new Array<SongMetadata>();
            for (j in 0...swagWeek.songs.length)
            {
                songs.push(Songs.filter(f -> f.songName.toLowerCase() == swagWeek.songs[j].toLowerCase())[0]);
            }
            swagWeek.difficulties = FindCommonSharedDifficulties(songs);
            Weeks.push(swagWeek);
        }
    }

    public static function AllowInterpStuff(interp:Interp)
    {
        interp.variables.set("Math",Math);
        //interp.variables.set("Config",Config); //nevermind dont do this this is DANGEROUS
        interp.variables.set("PlayState",PlayState);
        interp.variables.set("PauseSubState",PauseSubState);
        interp.variables.set("FlxEase",FlxEase);
        interp.variables.set("FlxTween",FlxTween);
        interp.variables.set("Note",Note);
        interp.variables.set("StrumNote",StrumNote);
        interp.variables.set("FlxG",FlxG);
        interp.variables.set("Paths",Paths);
        interp.variables.set("CoolUtil",CoolUtil);
        interp.variables.set("FlxSprite",FlxSprite);
        interp.variables.set("CurState",FlxG.state);
        interp.variables.set("Std",Std);
        interp.variables.set("FlxSound",FlxSound);
        interp.variables.set("FlxTimer",FlxTimer);
        interp.variables.set("ScriptUtils",ScriptUtils);

        //stupid
        interp.variables.set("BackgroundDancer",BackgroundDancer);
        interp.variables.set("BackgroundGirls",BackgroundGirls);
    }

    public static function FindCommonSharedDifficulties(songs:Array<SongMetadata>):Array<Difficulty>
    {
        var difficultyCounts:Map<String,Int> = new Map<String,Int>();
        var difficultyOrder:Map<String,Int> = new Map<String,Int>();
        var allDifficulties:Array<Difficulty> = new Array<Difficulty>(); //stupid bs
        for (s in songs) //go through all songs, if it has a difficulty, add it to DifficultyCounts if it doesnt exist otherwise increment it by 1
        {
            for (i in 0... s.Difficulties.length)
            {
                var diff:Difficulty = s.Difficulties[i];
                allDifficulties.push(diff);
                if (difficultyCounts.exists(diff.Name))
                {
                    difficultyCounts[diff.Name] = difficultyCounts[diff.Name] + 1; //todo: see if "++" works
                    if (i < difficultyOrder[diff.Name]) //if the order here is less than anything found previously, put it first.
                    {
                        difficultyOrder[diff.Name] = i;
                    }
                }
                else
                {
                    difficultyCounts.set(diff.Name, 1);
                    difficultyOrder.set(diff.Name,i); //if it doesnt exist in difficultycounts it 100% doesn't exist in difficultyOrder
                }
            }
        }
        var finalDifficulties:Array<Difficulty> = new Array<Difficulty>();

        for (key in difficultyCounts.keys())
        {
            if (difficultyCounts[key] == songs.length)
            {
                finalDifficulties.push(allDifficulties.filter(f -> f.Name == key)[0]); //find the first difficulty that matches. this is stupid.
            }
        }

        if (finalDifficulties.length == 0)
        {
            throw new Exception("None of the songs provided share any difficulties!");
        }

        finalDifficulties.sort(function(d1:Difficulty, d2:Difficulty):Int
        {
            return difficultyOrder[d1.Name] - difficultyOrder[d2.Name];
        });

        return finalDifficulties;
    }


    public static function getDifficulties(songname:String):Array<Difficulty>
    {
        var difficultiesFile = CoolUtil.coolTextFileWithMods(Paths.txt(songname.toLowerCase() + '/' + "difficulties"));

        var difficulties:Array<Difficulty> = new Array<Difficulty>();

        for (i in 0...difficultiesFile.length)
        {
            var splitstring:Array<String> = difficultiesFile[i].split(",");
            splitstring = splitstring.filter(f -> f != "");
            var diffname:String = splitstring[0];
            var diffcolor:FlxColor = FlxColor.WHITE;
            if (splitstring.length > 1)
            {
                diffcolor = FlxColor.fromString(splitstring[1]); //create color from hex code
            }
            else
            {
                if (MasterColors.exists("diff_" + diffname.toLowerCase()))
                {
                    diffcolor = MasterColors.get("diff_" + diffname.toLowerCase());
                }
            }
            difficulties.push(new Difficulty(diffname,diffcolor));
        }

        return difficulties;
    }

}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
    public var Difficulties:Array<Difficulty>;

	public function new(song:String, week:Int, songCharacter:String, difficulties:Array<Difficulty>)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
        this.Difficulties = difficulties;
	}
}

typedef WeekMetadata = 
{
    public var name:String;
    public var songs:Array<String>;
    public var characters:Array<String>;
    public var weekTitle:String;
    public var difficulties:Array<Difficulty>;
}

class Difficulty
{
    public var Name:String = "UNDEFINED";
    public var Color:FlxColor = FlxColor.WHITE;

    public function new(n:String, c:FlxColor)
    {
        Name = n;
        Color = c;
    }
}
