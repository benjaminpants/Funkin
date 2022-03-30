package;

import GameplayOptionsSubState.GameplayOptionsSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends OptionsMenuParent
{


	public function new()
	{
		super();
		textMenuItems = ['Master Volume', 'Sound Volume', 'Gameplay', 'Controls'];
		CreateText();
	}

	override function OnEscape()
	{
		FlxG.switchState(new MainMenuState());
	}

	override function OnSelection(selection:String,text:Alphabet)
	{
		switch (selection)
		{
			case "Gameplay":
				FlxG.state.closeSubState();
				FlxG.state.openSubState(new GameplayOptionsSubState());
			case "Controls":
				FlxG.state.closeSubState();
				FlxG.state.openSubState(new KeybindsSubState());
		}
	}
}
