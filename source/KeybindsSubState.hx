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
    public static var kbArray:Map<String,String> = ["Left Alt" => "A", "Down Alt" => "S", "Up Alt" => "W", "Right Alt" => "D"];
	var kbArrayIds:Array<String> = ["Left Alt", "Down Alt", "Up Alt", "Right Alt"];
	var states:String = "idle";
	//left down up right


	function StringHasDirection(a:String):Bool
	{
		return (a.indexOf("Left") != -1 || a.indexOf("Up") != -1 || a.indexOf("Down") != -1 || a.indexOf("Right") != -1);
	}

	public function UpdateTextMenu()
	{
		textMenuItems = [];

        for (i in 0...kbArrayIds.length)
		{
			textMenuItems.push(kbArrayIds[i] + " is " + kbArray[kbArrayIds[i]]);
			kbArrayIds.push(kbArrayIds[i]);
		}
	}

	public function new()
	{
		super();

		if(FlxG.save.data.keybinds_new == null){
			FlxG.save.data.keybinds_new = kbArray;
		}
		kbArray = FlxG.save.data.keybinds_new;
		
		UpdateTextMenu();

		CreateText();
	}


	override function update(elapsed:Float)
	{
		switch(states){
			case 'selecting':
				if(FlxG.keys.justPressed.ESCAPE){
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
					allowInput = true;
				}
				else if(FlxG.keys.justPressed.ENTER){
					states = 'idle';
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					grpOptionsTexts.remove(grpOptionsTexts.members[curSelected]);
					ChangeText(curSelected, textMenuItems[curSelected]);
					allowInput = true;
				}
				else if(FlxG.keys.justPressed.ANY){
					kbArray[kbArrayIds[curSelected]] = FlxG.keys.getIsDown()[0].ID.toString();
					UpdateTextMenu();
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
		FlxG.save.data.keybinds_new = kbArray;
		controls.setKeyboardScheme(KeyboardScheme.Solo, true);
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