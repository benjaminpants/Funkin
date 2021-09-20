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
		textMenuItems = ["Ghost Notes: " + (FlxG.save.data.ghostnotes ? "On" : "Off"),"FPS Cap: " + FlxG.save.data.fpscap,(FlxG.save.data.downscroll ? "Downscroll" : "Upscroll")];
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
		switch (text.ID)
		{
			case 0:
				FlxG.save.data.ghostnotes = !FlxG.save.data.ghostnotes;
				ChangeText(0,"Ghost Notes: " + (FlxG.save.data.ghostnotes ? "On" : "Off"));
			case 2:
				FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
				ChangeText(2,(FlxG.save.data.downscroll ? "Downscroll" : "Upscroll"));
		}
	}

	override function OnIncrement(selection:String,change:Int, text:Alphabet)
	{
		switch (text.ID)
		{
			case 1:
				if (!((FlxG.save.data.fpscap + (change * 15)) <= 0))
				{
					FlxG.save.data.fpscap = FlxG.save.data.fpscap + (change * 15);
				}
				ChangeText(1,"FPS Cap: " + FlxG.save.data.fpscap);
				openfl.Lib.current.stage.frameRate = FlxG.save.data.fpscap;

		}
	}



}
