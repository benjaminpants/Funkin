#if hscript

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;


class Script //give every script its own interpreter so no variable conflicts!!!!
{

    public static var functionBlacklist:Map<ScriptType,Array<String>> = [
        ScriptType.Basic => [],
        ScriptType.Stage => ['create']


    ];



    public var hscriptInterp:Interp = new Interp();
	public var hscriptCurScript:Expr;
    public var type:ScriptType = ScriptType.Basic;

    public function new(parser:Parser, script:String, ?tp:ScriptType = ScriptType.Basic)
    {
        hscriptCurScript = parser.parseString(script);
        Config.AllowInterpStuff(hscriptInterp);
        hscriptInterp.errorHandler = Script.ErrorHandler;
        hscriptInterp.execute(hscriptCurScript);
        type = tp;
    }

    public static function ErrorHandler(e:hscript.Error)
    {
        trace("Error with HSCRIPT!!\n" + e);
    }

    public function CallFunction(funcName:String, ?args:Array<Dynamic>):Dynamic
    {
        if (hscriptInterp.variables.get(funcName) == null)
        {
            return null;
        }
        var output:Dynamic = null;
        try
        {
            output = hscriptInterp.variables.get(funcName)(args);
        }
        catch(e)
        {
            trace("error!" + e.message);
        }
        return output;
    }

}


enum ScriptType
{
    Basic; Stage; NoteScript;
}

#end