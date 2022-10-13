package;

import sys.FileSystem;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{

	public static function coolTextFile(path:String):Array<String>
	{
		if (!FileSystem.exists(path)) 
		{
			return [];
		}
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}


	public static function coolTextFileWithMods(path:String):Array<String>
	{
		var modPath:String = Paths.mods();
		var daList:Array<String> = coolTextFile(path); //built in is ALWAYS first
		for (mpath in Paths.foundModsPath)
		{
			var pot_path = haxe.io.Path.join([modPath, mpath, path]);
			if (FileSystem.exists(pot_path))
			{
				daList = daList.concat(coolTextFile(pot_path));
			}
		}
		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

}
