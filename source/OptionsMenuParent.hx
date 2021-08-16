package;

import polymod.format.ParseRules.TextFileFormat;
import GameplayOptionsSubState.GameplayOptionsSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsMenuParent extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['if u see this report this to a dev!!'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

	}

	function CreateText()
	{
		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		if (controls.LEFT_P)
		{
			var texttoprovide:FlxText = null;
	
			grpOptionsTexts.forEach(function(txt:FlxText)
			{
				if (txt.ID == curSelected)
					texttoprovide = txt;
			});
			OnIncrement(textMenuItems[curSelected],-1,texttoprovide);
		}

		if (controls.RIGHT_P)
		{
			var texttoprovide:FlxText = null;
	
			grpOptionsTexts.forEach(function(txt:FlxText)
			{
				if (txt.ID == curSelected)
					texttoprovide = txt;
			});
			
			OnIncrement(textMenuItems[curSelected],1,texttoprovide);
		}

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.BACK)
			OnEscape();

		if (controls.ACCEPT)
		{
			var texttoprovide:FlxText = null;

			grpOptionsTexts.forEach(function(txt:FlxText)
			{
				if (txt.ID == curSelected)
					texttoprovide = txt;
			});

			OnSelection(textMenuItems[curSelected],texttoprovide);
		}
	}

	function OnEscape()
	{
		
	}

	function OnSelection(selection:String,text:FlxText)
	{

	}

	function OnIncrement(selection:String,change:Int, text:FlxText)
	{
	
	}
}
