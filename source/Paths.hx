package;

import flixel.FlxG;
import sys.FileSystem;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	public static var foundModsPath:Array<String>;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}
	
	inline static public function mods(key:String = "") 
	{
		return 'mods/' + key;
	}
	static public function getModDirectories():Array<String> 
	{
		var foundMods:Array<String> = [];
		var modsFolder:String = mods();
		if(FileSystem.exists(modsFolder)) 
		{
			for (folder in FileSystem.readDirectory(modsFolder))
			{
				var path = haxe.io.Path.join([modsFolder, folder]);
				if (FileSystem.isDirectory(path))
				{
					foundMods.push(folder);
				}
			}
		}

		return foundMods;
	}

	static function getfromMod(file:String)
	{
		for (p in foundModsPath)
		{
			if (FileSystem.exists(p + '/assets/$file'))
			{
				return p + '/assets/$file';
			}
		}
		return 'assets/$file';
	}

	static function getAllModFiles(file:String, includeBase:Bool):Array<String>
	{
		var allFiles:Array<String> = [];

		for (p in foundModsPath)
		{
			if (FileSystem.exists(p + '/assets/$file'))
			{
				allFiles.push(p + '/assets/$file');
			}
		}

		return allFiles;
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	//Assets.getText(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase())).trim();

	inline static public function hx(key:String, ?library:String)
	{
		return getPath('data/$key.hx', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}
	

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function firstModWithFile(path:String, assetType:AssetType, ?library:String, ?extensionIfVanilla:String = '')
	{
		#if mod_support
		for (mpath in Paths.foundModsPath)
		{
			var pot_path:String = haxe.io.Path.join([mods(mpath),"assets",path]);
			if (FileSystem.exists(pot_path))
			{
				return pot_path;
			}
		}
		#end
		return extensionIfVanilla + getPath(path, TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String)
	{
		return firstModWithFile('songs/${song.toLowerCase()}/Voices.$SOUND_EXT',SOUND,null,'songs:');
	}

	inline static public function inst(song:String)
	{
		return firstModWithFile('songs/${song.toLowerCase()}/Inst.$SOUND_EXT',SOUND,null,'songs:');//'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}


	inline static public function jsonMod(key:String, ?library:String)
	{
		return firstModWithFile('data/$key.json',TEXT,library);
	}

	inline static public function extensionModText(key:String, extension:String, ?library:String)
	{
		return firstModWithFile('data/$key.$extension',TEXT,library);
	}
}
