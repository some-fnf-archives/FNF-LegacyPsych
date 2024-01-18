package tools;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.ui.FlxButton;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flash.net.FileFilter;
import haxe.Json;
import DialogueBoxPsych;
import lime.system.Clipboard;
import Alphabet;
import flixel.group.FlxSpriteGroup;

#if sys
import sys.io.File;
#end

using StringTools;

class DialogueUtil extends FlxSpriteGroup
{
    private static var DEFAULT_TEXT:String = "coolswag";
	private static var DEFAULT_SPEED:Float = 0.05;
	private static var DEFAULT_BUBBLETYPE:String = "normal";
    public static var skipNextClear = false;
    public static var buffer:Array<DialogueLine> = [];

    public static function makeLine(
        text:String, 
        portrait:String = 'bf',
        expression:String = 'talk', 
        boxState:String = 'normal',
        speed:Float = 0.05,
        sound:String = ''
    ):DialogueLine{

        var defaultLine:DialogueLine = {
            portrait: portrait,
            expression: expression,
            text: text,
            boxState: boxState,
            speed: speed,
            sound: sound
        };
        
        buffer.push(defaultLine);
        return defaultLine;
    }

    public static function getLine(i:Int){
        var dummyLine:DialogueLine = {
            portrait: '',
            expression: '',
            text: 'text',
            boxState: '',
            speed: 0.05,
            sound: ''
        };

        if(buffer.length> i && i>=0)
            return buffer[i];

        return dummyLine;
    }
}
