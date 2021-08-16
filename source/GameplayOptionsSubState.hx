package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.Lib;

class GameplayOptionsSubState extends OptionsMenuParent
{
	public function new()
	{
		super();
		textMenuItems = ["Ghost Notes: " + (FlxG.save.data.ghostnotes ? "On" : "Off"),"FPS Cap: " + FlxG.save.data.fpscap];
		CreateText();
	}


	override function OnEscape()
	{
		FlxG.save.flush();
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new OptionsSubState());
	}
	
	override function OnSelection(selection:String,text:FlxText)
	{
		switch (text.ID)
		{
			case 0:
				FlxG.save.data.ghostnotes = !FlxG.save.data.ghostnotes;
				text.text = "Ghost Notes: " + (FlxG.save.data.ghostnotes ? "On" : "Off");
		}
	}

	override function OnIncrement(selection:String,change:Int, text:FlxText)
	{
		switch (text.ID)
		{
			case 1:
				if (!((FlxG.save.data.fpscap + (change * 15)) <= 0))
				{
					FlxG.save.data.fpscap = FlxG.save.data.fpscap + (change * 15);
				}
				text.text = "FPS Cap: " + FlxG.save.data.fpscap;
				openfl.Lib.current.stage.frameRate = FlxG.save.data.fpscap;

		}
	}



}
