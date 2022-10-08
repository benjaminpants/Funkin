package;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	private static var PixelCharacters:Array<String> = [ "bf-pixel", "senpai", "senpai-angry", "spirit" ];

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = !PixelCharacters.contains(char);
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('face', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		if (animation.exists(char))
		{
			animation.play(char);
		}
		else
		{
			animation.play('face');
		}
		scrollFactor.set();
	}


	public static function GetIconColorStatic(Layer:Int = 0, character:String = "bf")
	{
		switch (character)
		{
			case 'bf':
				return new FlxColor(0xFF31B0D1);
			case 'bf-car':
				return new FlxColor(0xFF31B0D1);
			case 'bf-christmas':
				return new FlxColor(0xFF31B0D1);
			case 'bf-pixel':
				return new FlxColor(0xFF7BD6F6);
			case 'spooky':
				return Layer == 0 ? new FlxColor(0xFFD57E00) : new FlxColor(0xFFB4B4B4);
			case 'pico':
				return new FlxColor(0xFFB7D855);
			case 'mom':
				return new FlxColor(0xFFD8558E);
			case 'mom-car':
				return new FlxColor(0xFFD8558E);
			case 'tankman':
				return new FlxColor(0xFF020202);
			case 'face':
				return new FlxColor(0xFFA1A1A1);
			case 'dad':
				return new FlxColor(0xFFAF66CE);
			case 'senpai':
				return new FlxColor(0xFFFFAA6F);
			case 'senpai-angry':
				return new FlxColor(0xFFFFAA6F);
			case 'spirit':
				return new FlxColor(0xFFFF3C6E);
			case 'bf-old':
				return new FlxColor(0xFFE9FF48);
			case 'gf':
				return new FlxColor(0xFFA5004D);
			case 'parents-christmas':
				return Layer == 0 ? GetIconColorStatic('mom') : GetIconColorStatic('dad');
			case 'monster':
				return new FlxColor(0xFFF3FF6E);
			case 'monster-christmas':
				return new FlxColor(0xFFF3FF6E);
			default:
				return new FlxColor(0xFFA1A1A1);
		}
	}

	public function GetIconColor(Layer:Int = 0):FlxColor
	{
		return GetIconColorStatic(Layer, animation.name);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
