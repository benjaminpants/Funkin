package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;


class DialogueCharacter
{
    public var CharacterPath:String = "weeb/bfPortrait";
    public var CharacterEnterAnim:String = "Boyfriend portrait enter";
    public var OnLeftSide:Bool = false;
    public var SoundToPlay:String = "BF_";
    public var IsPixel:Bool = false;
    public var MaxSounds:Int = 1;

    public function new(charpath:String,charanim:String,leftside:Bool,soundplay:String,maxsnds:Int,pixel:Bool)
    {
        CharacterPath = charpath;
        CharacterEnterAnim = charanim;
        OnLeftSide = leftside;
        SoundToPlay = soundplay;
        IsPixel = pixel;
        MaxSounds = maxsnds;
    }
}