package;

import polymod.format.ParseRules.TextFileFormat;
import GameplayOptionsSubState.GameplayOptionsSubState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsMenuParent extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['if u see this report this to a dev!!'];

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

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.screenCenter(X);
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;
			changeItemPos();

		if (controls.DOWN_P)
			curSelected += 1;
			changeItemPos();

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

			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

			grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
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

			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

			grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
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

			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

			grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
			OnSelection(textMenuItems[curSelected],texttoprovide);
		}
	}

	function OnEscape()
	{
		
	}

	function changeItemPos(){
		var bullShit:Int = 0;

		for (item in grpOptionsTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

	public function ChangeText(id:Int, string:String)
	{
		var optionText:Alphabet = new Alphabet(10, (70 * curSelected) + 30, string, true, false);
		optionText.ID = id;
		optionText.isMenuItem = true;
		optionText.targetY = curSelected - id;
		optionText.screenCenter(X);
		grpOptionsTexts.add(optionText);
	}

	function OnSelection(selection:String,text:Alphabet)
	{

	}

	function OnIncrement(selection:String,change:Int, text:Alphabet)
	{
	
	}
}
