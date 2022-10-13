#if hscript

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;


class Script //give every script its own interpreter so no variable conflicts!!!!
{
    public var hscriptInterp:Interp = new Interp();
	public var hscriptCurScript:Expr;

    public function new(parser:Parser, script:String)
    {
        hscriptCurScript = parser.parseString(script);
        Config.AllowInterpStuff(hscriptInterp);
        hscriptInterp.errorHandler = Script.ErrorHandler;
        hscriptInterp.execute(hscriptCurScript);
    }

    public static function ErrorHandler(e:hscript.Error)
    {
        trace("Error with HSCRIPT!!\n" + e);
    }

    public function CallFunction(funcName:String, ?args:Array<Dynamic>):Dynamic
    {
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





#end