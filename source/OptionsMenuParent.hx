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

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

	public function new()
	{
		super();

	}

	function CreateText()
	{
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(10, 20 + (i * 75), textMenuItems[i], true, false);
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
			var texttoprovide:Alphabet = null;
	
			grpOptionsTexts.forEach(function(txt:Alphabet)
			{
				if (txt.ID == curSelected)
					texttoprovide = txt;
			});
			OnIncrement(textMenuItems[curSelected],-1,texttoprovide);
		}

		if (controls.RIGHT_P)
		{
			var texttoprovide:Alphabet = null;
	
			grpOptionsTexts.forEach(function(txt:Alphabet)
			{
				if (txt.ID == curSelected)
					texttoprovide = txt;
			});
			
			OnIncrement(textMenuItems[curSelected],1,texttoprovide);
		}

		grpOptionsTexts.forEach(function(txt:Alphabet)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.BACK)
			OnEscape();

		if (controls.ACCEPT)
		{
			var texttoprovide:Alphabet = null;

			grpOptionsTexts.forEach(function(txt:Alphabet)
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

	function OnSelection(selection:String,text:Alphabet)
	{

	}

	function OnIncrement(selection:String,change:Int, text:Alphabet)
	{
	
	}
}
