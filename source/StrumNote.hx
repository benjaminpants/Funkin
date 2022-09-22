package;

import flixel.FlxSprite;

class StrumNote extends FlxSprite
{
	public var baseX:Float;
	public var playerStrum:Bool;
    public function new(x:Float, y:Float, type:String, strumID:Int, playerStrum:Bool)
    {
        super(x, y);
        baseX = x;

        ID = strumID;

        switch (type)
        {
            default:
                frames = Paths.getSparrowAtlas('NOTE_assets');
            case 'pixel':
                loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
        }
        //actually load in the animation
        switch (type)
        {
            //loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
            case 'pixel':
                animation.add('green', [6]);
                animation.add('red', [7]);
                animation.add('blue', [5]);
                animation.add('purplel', [4]);

                setGraphicSize(Std.int(width * PlayState.daPixelZoom));
                updateHitbox();
                antialiasing = false;

                switch (Math.abs(strumID))
                {
                    case 0:
                        animation.add('static', [0]);
                        animation.add('pressed', [4, 8], 12, false);
                        animation.add('confirm', [12, 16], 24, false);
                    case 1:
                        animation.add('static', [1]);
                        animation.add('pressed', [5, 9], 12, false);
                        animation.add('confirm', [13, 17], 24, false);
                    case 2:
                        animation.add('static', [2]);
                        animation.add('pressed', [6, 10], 12, false);
                        animation.add('confirm', [14, 18], 12, false);
                    case 3:
                        animation.add('static', [3]);
                        animation.add('pressed', [7, 11], 12, false);
                        animation.add('confirm', [15, 19], 24, false);
                }
            default:
                animation.addByPrefix('green', 'arrowUP');
                animation.addByPrefix('blue', 'arrowDOWN');
                animation.addByPrefix('purple', 'arrowLEFT');
                animation.addByPrefix('red', 'arrowRIGHT');
                switch (Math.abs(strumID))
                {
                    case 0:
                        animation.addByPrefix('static', 'arrowLEFT');
                        animation.addByPrefix('pressed', 'left press', 24, false);
                        animation.addByPrefix('confirm', 'left confirm', 24, false);
                    case 1:
                        animation.addByPrefix('static', 'arrowDOWN');
                        animation.addByPrefix('pressed', 'down press', 24, false);
                        animation.addByPrefix('confirm', 'down confirm', 24, false);
                    case 2:
                        animation.addByPrefix('static', 'arrowUP');
                        animation.addByPrefix('pressed', 'up press', 24, false);
                        animation.addByPrefix('confirm', 'up confirm', 24, false);
                    case 3:
                        animation.addByPrefix('static', 'arrowRIGHT');
                        animation.addByPrefix('pressed', 'right press', 24, false);
                        animation.addByPrefix('confirm', 'right confirm', 24, false);
                }
                setGraphicSize(Std.int(width * 0.7));
                updateHitbox();
        }
        animation.play('static');

        antialiasing = type != 'pixel';

        scrollFactor.set();

        this.playerStrum = playerStrum;
    }
	public function resetX()
	{
		x = baseX;
	}
}