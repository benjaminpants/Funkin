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
			FlxG.save.data.keybinds = kbArray;
		}
		kbArray = FlxG.save.data.keybinds;
        textMenuItems = ["Left Note is " + kbArray[0], "Right Note is " + kbArray[1], "Up Note is " + kbArray[2], "Down Note is " + kbArray[3]];
		CreateText();
	}

	override function update(elapsed:Float)
	{
		switch(states){
			case 'selecting':
				if(FlxG.keys.justPressed.ESCAPE){
					FlxG.save.data.keybinds[curSelected] = kbArray[curSelected];
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
					allowInput = true;
				}
				else if(FlxG.keys.justPressed.ENTER){
					FlxG.save.data.keybinds[curSelected] = kbArray[curSelected];
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
					allowInput = true;
				}
				else if(FlxG.keys.justPressed.ANY){
					kbArray[curSelected] = FlxG.keys.getIsDown()[0].ID.toString();
					textMenuItems = ["Left Note is " + kbArray[0], "Right Note is " + kbArray[1], "Up Note is " + kbArray[2], "Down Note is " + kbArray[3]];
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
					allowInput = true;
				}
		}
		super.update(elapsed);
	}

	override function OnEscape()
	{
		FlxG.save.data.keybinds = kbArray;
		FlxG.save.flush();
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new OptionsSubState());
	}

	override function OnSelection(selection:String,text:Alphabet)
	{
		if(states == 'idle'){
			states = 'selecting';
			allowInput = false;
			ChangeText(curSelected, 'Waiting input');
		}
		else if(states == 'selecting'){
			states = 'idle';
			allowInput = true;
			ChangeText(curSelected, textMenuItems[curSelected]);
		}

	}

}