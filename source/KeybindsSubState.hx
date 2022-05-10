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
	var kbArrayIds:Array<String> = [];
	var states:String = "idle";
	//left down up right

	public function UpdateTextMenu()
	{
		textMenuItems = [];
		kbArrayIds = [];
        for (key => value in kbArray)
		{
			textMenuItems.push(key + " is " + value);
			kbArrayIds.push(key);
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