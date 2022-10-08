//parents-seperate-test

import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;

using StringTools;

class ExampleCustomCharacter extends Character
{

    public var ValidAnimations:Array<String> = ["idle","singup","singdown","singleft","singright"];

    public var FunnyCharacter:FlxSprite;

    public var startPos:FlxPoint;

    public override function animationExists(animationToCheck:String):Bool 
    {
        return ValidAnimations.contains(animationToCheck.toLowerCase());
    }

    public override function canChangetoAnim(AnimToChange:String):Bool {
        return animationExists(AnimToChange);
    }

    public override function getGraphicMidpoint(?point:FlxPoint):FlxPoint 
    {
        return FunnyCharacter.getGraphicMidpoint();
    }

    public function new(x:Float, y:Float, ?character:String = "bf", ?isActPlayer:Bool = false)
    {
        super(x,y,character,isActPlayer);

        startPos = new FlxPoint(x,y);

        FunnyCharacter = new FlxSprite(x,y);

        FunnyCharacter.antialiasing = true;

        FunnyCharacter.frames = Paths.getSparrowAtlas('NOTE_assets');

        FunnyCharacter.animation.addByPrefix('green', 'arrowUP');
        FunnyCharacter.animation.addByPrefix('blue', 'arrowDOWN');
        FunnyCharacter.animation.addByPrefix('purple', 'arrowLEFT');
        FunnyCharacter.animation.addByPrefix('red', 'arrowRIGHT');

        FunnyCharacter.animation.play('blue');

        add(FunnyCharacter);

    }

    public override function update(elapsed:Float) 
    {
        if (currentAnim.startsWith('sing'))
		{
            holdTimer += elapsed;
        }
        switch (currentAnim.toLowerCase())
        {
            default:
                x = FlxMath.lerp(x,startPos.x,0.2);
                y = FlxMath.lerp(y,startPos.y,0.2);
            case 'singup':
                FunnyCharacter.animation.play('green');
                y -= elapsed * 64;
            case 'singdown':
                FunnyCharacter.animation.play('blue');
                y += elapsed * 64;
            case 'singleft':
                FunnyCharacter.animation.play('purple');
                x -= elapsed * 64;
            case 'singright':
                FunnyCharacter.animation.play('red');
                x += elapsed * 64;
        }
        if (holdTimer >= 1)
        {
            playAnim('idle',true);
        }
        super.update(elapsed);
    }

    public override function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Bool 
    {
        if (super.playAnim(AnimName, Force, Reversed, Frame))
        {
            if (AnimName.toLowerCase().contains('sing'))
            {
                holdTimer = 0;
                trace(holdTimer);
            }
            return true;
        }
        return false;
    }

}