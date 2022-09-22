import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;

using StringTools;

class Character extends FlxTypedSpriteGroup<FlxSprite>
{

    @:isVar public var currentAnim(get, set):String;

    public function get_currentAnim() 
    {
        return currentAnim;
    }

    private function set_currentAnim(x) 
    {
        return this.currentAnim = currentAnim;
    }

    public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

    var danced:Bool = false;

    public function animationExists(animationToCheck:String):Bool
    {
        return false;
    }

    public function new(x:Float, y:Float, ?character:String = "bf", ?isSetPlayer:Bool = false)
    {
        super(x,y);
        curCharacter = character;
        isPlayer = isSetPlayer;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    public function dance()
    {

    }

    public function canChangetoAnim(AnimToChange:String):Bool
    {
        return true;
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
    {
        if (!Force)
        {
            if (!canChangetoAnim(AnimName))
            {
                return;
            }
        }
        currentAnim = AnimName;
    }
}