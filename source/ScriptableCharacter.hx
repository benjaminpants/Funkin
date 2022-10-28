import Config.CharacterMetadata;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import lime.utils.Assets;

using StringTools;

class ScriptableCharacter extends Character
{

    public var script:Script;

    public var myMetadata:CharacterMetadata;

    public override function animationExists(animationToCheck:String):Bool 
    {
        return script.CallFunction("animationExists",[animationToCheck]);
    }

    public override function canChangetoAnim(AnimToChange:String):Bool 
    {
        return script.CallFunction("canChangetoAnim",[AnimToChange]);
    }

    public override function getGraphicMidpoint(?point:FlxPoint):FlxPoint 
    {
        return script.CallFunction("getGraphicMidpoint",[point]);
    }

    public override function dance() 
    {
        script.CallFunction("dance");
    }

    public function new(x:Float, y:Float, ?character:String = "bf", ?isActPlayer:Bool = false)
    {
        super(x,y,character,isActPlayer);

        myMetadata = Config.Characters.filter(f -> f.name == character)[0]; //its very bad to assume the man exists but we gotta

        var chartouse:String = myMetadata.alternateCharacterScript == null ? character : myMetadata.alternateCharacterScript;

        var characterscriptpath:String = Paths.extensionModText('characters/$chartouse/script','hx');

        script = new Script(Main.hscriptParser,Assets.getText(characterscriptpath),Script.ScriptType.Character);

        Config.AllowInterpStuff(script.hscriptInterp,this);

        script.CallFunction("new",[x,y,character,isActPlayer]);


    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);

        script.CallFunction("update",[elapsed]);
    }

    public override function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Bool 
    {
        return script.CallFunction("playAnim",[AnimName,Force,Reversed,Frame]);
    }

}