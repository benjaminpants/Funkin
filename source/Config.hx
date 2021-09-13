import NoteType;
import lime.system.System;
import flixel.system.debug.log.Log;
import flixel.FlxG;
import DialogueCharacter;


class Config
{
    //mod specific config settings will go here
    public static var Company:String = "ninjamuffin99";
    public static var Game:String = "funkin";

    public static var EngineVersion:String = "0.0(Not ready for use)";

    public static var PixelStages:Array<String> = [ "senpai", "roses", "thorns" ];

    public static var DialogueCharacters:Map<String,DialogueCharacter> = [
        "bf-pixel" => new DialogueCharacter("weeb/bfPortrait",'Boyfriend portrait enter',false,"pixel_",1,true),
        "senpai" => new DialogueCharacter("weeb/senpaiPortrait",'Senpai Portrait Enter',true,"pixel_",1,true),
        "invisible" => new DialogueCharacter("nonePortrait",'Senpai Portrait Enter instance 1',true,"pixel_",1,true),
    ];

    public static var NoteTypes:Array<NoteTypeBase> = [
        new NoteTypeBase()
    ];



}