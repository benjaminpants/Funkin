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
    var kbArray = ['A', 'D', 'W', 'S'];
	var states:String = "idle";
	//left right up down

	public function new()
	{
		super();
		if(FlxG.save.data.keybinds == null){
			FlxG.save.data.keybinds = ['A', 'D', 'W', 'S'];
		}
		for (i in 0...FlxG.save.data.keybinds){
			kbArray[i] = FlxG.save.data.keybinds[i];
		}
        textMenuItems = ["Left Note is " + kbArray[0], "Right Note is " + kbArray[1], "Up Note is " + kbArray[2], "Down Note is " + kbArray[3]];
		CreateText();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		switch(states){
			case 'idle':
				if (controls.UP_P)
					curSelected -= 1;

				if (controls.DOWN_P)
					curSelected += 1;

				if (curSelected >= textMenuItems.length)
					curSelected = 0;

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
				trace(curSelected);
			case 'selecting':
				if(FlxG.keys.justPressed.ESCAPE){
					FlxG.save.data.keybinds[curSelected] = kbArray[curSelected];
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
				}
				else if(FlxG.keys.justPressed.ENTER){
					FlxG.save.data.keybinds[curSelected] = kbArray[curSelected];
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
				}
				else if(FlxG.keys.justPressed.ANY){
					kbArray[curSelected] = FlxG.keys.getIsDown()[0].ID.toString();
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
				}
				trace(curSelected);
		}
	}

	override function OnEscape()
	{
		FlxG.save.flush();
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new GameplayOptionsSubState());
	}

	override function OnSelection(selection:String,text:Alphabet)
	{
		if(states == 'idle'){
			states = 'selecting';
			ChangeText(curSelected, 'Waiting for keyboard input');
		}
		else if(states == 'selecting'){
			states = 'idle';
			ChangeText(curSelected, textMenuItems[curSelected]);
		}

	}

}