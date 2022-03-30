package;

import Controls.Control;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.Lib;

class KeybindsSubState extends OptionsMenuParent
{
    var kbArray = [Control.LEFT, Control.RIGHT, Control.UP, Control.DOWN];

	public function new()
	{
		super();
        textMenuItems = ["Left Note is " + kbArray[0], "Right Note is " + kbArray[1], "Up Note is " + kbArray[2], "Down Note is " + kbArray[3]];
		CreateText();
	}


	override function OnEscape()
	{
		FlxG.save.flush();
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new OptionsSubState());
	}

	override function OnSelection(selection:String,text:Alphabet)
	{

	}

}