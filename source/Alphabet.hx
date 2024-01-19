package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.sound.FlxSound;
import flash.media.Sound;
import haxe.iterators.ArrayIterator;
import StringBuf;

using StringTools;

enum Alignment
{
	LEFT;
	CENTERED;
	RIGHT;
}



class ColorEvent
{
	public var input:String ="";
	public var colorToUse:FlxColor = 0xFFFFFF;
	//public static var PATTERN:EReg = ~/<([^|]+)([|])([^|]+)>/;  
	//public static var PATTERN_GLOBAL:EReg = ~/<([^|]+)([|])([^|]+)>/g;  
	
	/*
	public static function getMatches(ereg:EReg, input:String):Array<Array<String>> {
		var matches = [];
		try{
			while (ereg.match(input)) {
				matches.push([ereg.matched(1),ereg.matched(3)]); 
				input = ereg.matchedRight();
				//trace(input);
			}
		}
		catch(err){}
		trace(matches);
		return matches;
	}
	
	
	public static function isescape(str:String){
		var length = 0;
		try{
			var arr = getMatches(ColorEvent.PATTERN, str);
			//trace(arr);
			if (arr.length>0) { 
				length = 1;
			}
		}
		catch(err){}
		return length > 0;
	}
	*/
	
	public static function resolveColor(str:String):FlxColor{
		switch(str){
			case "red": return 0xFF0000;
			case "green": return 0x00FF00;
			case "blue": return 0x0000FF;
			default: 
				var color:Int = Std.parseInt(str);
				if(!str.startsWith('0x')) color = Std.parseInt('0xff' + str);
				return color;
		}
	}
	
	public function new(arr:Array<Dynamic>){
		try{
			colorToUse = resolveColor(arr[0]); 
			input = arr[1];
		}
		catch(err){}
		
		trace(colorToUse);
	}
	
	function toString(){
		return input;
	}
	
}


class Ansi /*extends CustomText*/ {
    //static var PATTERN:EReg = ~/<([^|]+)([|])([^|]+)>/;  // ~/(\\x1b\[[\d;]*[a-zA-Z])/;
    //static var PATTERN_LEFT:EReg = ~/<([^|]+)|[^|]+>/;  // ~/(\\x1b\[[\d;]*[a-zA-Z])/;
    //static var PATTERN_RIGHT:EReg = ~/<[^|]+|([^|]+)>/;  // ~/(\\x1b\[[\d;]*[a-zA-Z])/;
     // ~/(\\x1b\[[\d;]*[a-zA-Z])/;

    public static function escapes(str:String):haxe.iterators.ArrayIterator<Dynamic> {
        //var ereg:EReg = PATTERN;
        
        var results:Array<Dynamic> = [];// ColorEvent.PATTERN_GLOBAL.split(str);
        var s = str; 
		var s2 = new StringBuf();
		 
		var x =0;
		var substrs = [];
		var subindexes = [];
		
		//Fuck regex I'll do it myself
		while(x<s.length){
			var inp = [];
			var colorName = new StringBuf();
			var inputName = new StringBuf();
			for (i in x...s.length){
				var charI = s.charAt(i);
				if(charI=="<"){
					results.push(s2.toString());
					s2 = new StringBuf();
					inp[0] = i;
					x++;
					continue;
				}
				if(charI=="|"){
					inp[1] = i;
					x++;
					continue;
				}
				if(charI==">"){
					inp[2] = i;
				}
				
				switch(inp.length){
					case 0:s2.add(charI); 
					case 1:colorName.add(charI);
					case 2:inputName.add(charI);
					case 3:results.push(new ColorEvent([colorName.toString(),inputName.toString()]));
						colorName = new StringBuf();
						inputName = new StringBuf();
						subindexes.push(inp); 
						inp = []; s2 = new StringBuf();
				}
				x++;
			}
		}
		results.push(s2.toString());
		
		//var emptySpot = 0;
		
		
        /*for (match in ColorEvent.getMatches(ColorEvent.PATTERN,str)) {
            if (match.length == 0) continue;
            trace(match);
            while (results[emptySpot]!='' && emptySpot < results.length){
				emptySpot++;
			}
			
			if(emptySpot >= results.length){
				results.push(new ColorEvent([match[0],match[1]]));
            }
            else{
				results[emptySpot] = new ColorEvent([match[0],match[1]]);
			}
        }
        */
        if(results.length==0)
			results.push(s);
		
		
        return new ArrayIterator(results);
    }

}

class Alphabet extends FlxSpriteGroup
{
	public var text(default, set):String;

	public var bold:Bool = false;
	public var letters:Array<AlphaCharacter> = [];

	public var isMenuItem:Bool = false;
	public var targetY:Int = 0;
	public var changeX:Bool = true;
	public var changeY:Bool = true;

	public var alignment(default, set):Alignment = LEFT;
	public var scaleX(default, set):Float = 1;
	public var scaleY(default, set):Float = 1;
	public var rows:Int = 0;

	public var distancePerItem:FlxPoint = new FlxPoint(20, 120);
	public var startPosition:FlxPoint = new FlxPoint(0, 0); //for the calculations

	public function new(x:Float, y:Float, text:String = "", ?bold:Bool = true)
	{
		super(x, y);

		this.startPosition.x = x;
		this.startPosition.y = y;
		this.bold = bold;
		this.text = text;
	}

	public function setAlignmentFromString(align:String)
	{
		switch(align.toLowerCase().trim())
		{
			case 'right':
				alignment = RIGHT;
			case 'center' | 'centered':
				alignment = CENTERED;
			default:
				alignment = LEFT;
		}
	}

	private function set_alignment(align:Alignment)
	{
		alignment = align;
		updateAlignment();
		return align;
	}

	private function updateAlignment()
	{
		for (letter in letters)
		{
			var newOffset:Float = 0;
			switch(alignment)
			{
				case CENTERED:
					newOffset = letter.rowWidth / 2;
				case RIGHT:
					newOffset = letter.rowWidth;
				default:
					newOffset = 0;
			}
	
			letter.offset.x -= letter.alignOffset;
			letter.offset.x += newOffset;
			letter.alignOffset = newOffset;
		}
	}

	private function set_text(newText:String)
	{
		newText = newText.replace('\\n', '\n');
		//newText = newText.replace('<red|', '<FF0000|');
		clearLetters();
		createLetters(newText);
		updateAlignment();
		this.text = newText;
		/*var upp = "";
		for (i in Ansi.escapes(newText)){
			upp += "{"+i+"}";
		}
		trace(upp);*/
		return newText;
	}

	public function clearLetters()
	{
		var i:Int = letters.length;
		while (i > 0)
		{
			--i;
			var letter:AlphaCharacter = letters[i];
			if(letter != null)
			{
				letter.kill();
				letters.remove(letter);
				letter.destroy();
			}
		}
		letters = [];
		rows = 0;
	}

	private function set_scaleX(value:Float)
	{
		if (value == scaleX) return value;

		scale.x = value;
		for (letter in letters)
		{
			if(letter != null)
			{
				letter.updateHitbox();
				//letter.updateLetterOffset();
				var ratio:Float = (value / letter.spawnScale.x);
				letter.x = letter.spawnPos.x * ratio;
			}
		}
		scaleX = value;
		return value;
	}

	private function set_scaleY(value:Float)
	{
		if (value == scaleY) return value;

		scale.y = value;
		for (letter in letters)
		{
			if(letter != null)
			{
				letter.updateHitbox();
				letter.updateLetterOffset();
				var ratio:Float = (value / letter.spawnScale.y);
				letter.y = letter.spawnPos.y * ratio;
			}
		}
		scaleY = value;
		return value;
	}

	override function update(elapsed:Float)
	{
		if (isMenuItem)
		{
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 9.6, 0, 1);
			if(changeX)
				x = FlxMath.lerp(x, (targetY * distancePerItem.x) + startPosition.x, lerpVal);
			if(changeY)
				y = FlxMath.lerp(y, (targetY * 1.3 * distancePerItem.y) + startPosition.y, lerpVal);
		}
		super.update(elapsed);
	}

	public function snapToPosition()
	{
		if (isMenuItem)
		{
			if(changeX)
				x = (targetY * distancePerItem.x) + startPosition.x;
			if(changeY)
				y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
		}
	}

	private static var Y_PER_ROW:Float = 85;
	
	private function createLetters(newText:String)
	{
		var consecutiveSpaces:Int = 0;

		var xPos:Float = 0;
		var rowData:Array<Float> = [];
		rows = 0;
		
		//fix for options menu (uses > and <)
		var phrases:haxe.iterators.ArrayIterator<Dynamic> = newText.length<2?new ArrayIterator([newText]):Ansi.escapes(newText);
		
		for (phrase in phrases){
			var textToAdd:String = phrase.toString();
			var colorToUse = 0xFFFFFF;
			
			if (!Std.is(phrase, String)){
				colorToUse = phrase.colorToUse;
				textToAdd = phrase.input;
			}
			
			for (character in textToAdd.split(''))
			{
				if(character != '\n')
				{
					var spaceChar:Bool = (character == " " || (bold && character == "_"));
					if (spaceChar) consecutiveSpaces++;

					var isAlphabet:Bool = AlphaCharacter.isTypeAlphabet(character.toLowerCase());
					if (AlphaCharacter.allLetters.exists(character.toLowerCase()) && (!bold || !spaceChar))
					{
						if (consecutiveSpaces > 0)
						{
							xPos += 28 * consecutiveSpaces * scaleX;
							if(!bold && xPos >= FlxG.width * 0.65)
							{
								xPos = 0;
								rows++;
							}
						}
						consecutiveSpaces = 0;

						var letter:AlphaCharacter = new AlphaCharacter(xPos, rows * Y_PER_ROW * scaleY, character, bold, this);
						letter.x += letter.letterOffset[0] * scaleX;
						letter.y -= letter.letterOffset[1] * scaleY;
						letter.row = rows;

						var off:Float = 0;
						if(!bold) off = 2;
						xPos += letter.width + (letter.letterOffset[0] + off) * scaleX;
						rowData[rows] = xPos;
						
						if(colorToUse!=0xFFFFFF){
							var tColor = new FlxColor(colorToUse);
							letter.colorTransform.redOffset = tColor.red;
							letter.colorTransform.greenOffset = tColor.green;
							letter.colorTransform.blueOffset = tColor.blue;
						}
						add(letter);
						letters.push(letter);
					}
				}
				else
				{
					xPos = 0;
					rows++;
				}
			}
		}
		
		for (letter in letters)
		{
			letter.spawnPos.set(letter.x, letter.y);
			letter.spawnScale.set(scaleX, scaleY);
			letter.rowWidth = rowData[letter.row];
		}

		if(letters.length > 0) rows++;
	}
}


///////////////////////////////////////////
// ALPHABET LETTERS, SYMBOLS AND NUMBERS //
///////////////////////////////////////////

/*enum LetterType
{
	ALPHABET;
	NUMBER_OR_SYMBOL;
}*/

typedef Letter = {
	?anim:Null<String>,
	?offsets:Array<Float>,
	?offsetsBold:Array<Float>
}

class AlphaCharacter extends FlxSprite
{
	//public static var alphabet:String = "abcdefghijklmnopqrstuvwxyz";
	//public static var numbers:String = "1234567890";
	//public static var symbols:String = "|~#$%()*+-:;<=>@[]^_.,'!?";

	public var image(default, set):String;

	public static var allLetters:Map<String, Null<Letter>> = [
		//alphabet
		'a'  => null, 'b'  => null, 'c'  => null, 'd'  => null, 'e'  => null, 'f'  => null,
		'g'  => null, 'h'  => null, 'i'  => null, 'j'  => null, 'k'  => null, 'l'  => null,
		'm'  => null, 'n'  => null, 'o'  => null, 'p'  => null, 'q'  => null, 'r'  => null,
		's'  => null, 't'  => null, 'u'  => null, 'v'  => null, 'w'  => null, 'x'  => null,
		'y'  => null, 'z'  => null,
		
		//numbers
		'0'  => null, '1'  => null, '2'  => null, '3'  => null, '4'  => null,
		'5'  => null, '6'  => null, '7'  => null, '8'  => null, '9'  => null,

		//symbols
		'&'  => {offsetsBold: [0, 2]},
		'('  => {offsetsBold: [0, 5]},
		')'  => {offsetsBold: [0, 5]},
		'*'  => {offsets: [0, 28]},
		'+'  => {offsets: [0, 7], offsetsBold: [0, -12]},
		'-'  => {offsets: [0, 16], offsetsBold: [0, -30]},
		'<'  => {offsetsBold: [0, 4]},
		'>'  => {offsetsBold: [0, 4]},
		'\'' => {anim: 'apostrophe', offsets: [0, 32]},
		'"'  => {anim: 'quote', offsets: [0, 32], offsetsBold: [0, 0]},
		'!'  => {anim: 'exclamation', offsetsBold: [0, 10]},
		'?'  => {anim: 'question', offsetsBold: [0, 4]},			//also used for "unknown"
		'.'  => {anim: 'period', offsetsBold: [0, -44]},
		'❝'  => {anim: 'start quote', offsets: [0, 24], offsetsBold: [0, -5]},
		'❞'  => {anim: 'end quote', offsets: [0, 24], offsetsBold: [0, -5]},

		//symbols with no bold
		'_'  => null,
		'#'  => null,
		'$'  => null,
		'%'  => null,
		':'  => {offsets: [0, 2]},
		';'  => {offsets: [0, -2]},
		'@'  => null,
		'['  => null,
		']'  => {offsets: [0, -1]},
		'^'  => {offsets: [0, 28]},
		','  => {anim: 'comma', offsets: [0, -6]},
		'\\' => {anim: 'back slash', offsets: [0, 0]},
		'/'  => {anim: 'forward slash', offsets: [0, 0]},
		'|'  => null,
		'~'  => {offsets: [0, 16]}
	];

	var parent:Alphabet;
	public var alignOffset:Float = 0; //Don't change this
	public var letterOffset:Array<Float> = [0, 0];
	public var spawnPos:FlxPoint = new FlxPoint();
	public var spawnScale:FlxPoint = new FlxPoint();

	public var row:Int = 0;
	public var rowWidth:Float = 0;
	public function new(x:Float, y:Float, character:String, bold:Bool, parent:Alphabet)
	{
		super(x, y);
		this.parent = parent;
		image = 'alphabet';
		antialiasing = ClientPrefs.data.globalAntialiasing;

		var curLetter:Letter = allLetters.get('?');
		var lowercase = character.toLowerCase();
		if(allLetters.exists(lowercase)) curLetter = allLetters.get(lowercase);

		var suffix:String = '';
		if(!bold)
		{
			if(isTypeAlphabet(lowercase))
			{
				if(lowercase != character)
					suffix = ' uppercase';
				else
					suffix = ' lowercase';
			}
			else
			{
				suffix = ' normal';
				if(curLetter != null && curLetter.offsets != null)
				{
					letterOffset[0] = curLetter.offsets[0];
					letterOffset[1] = curLetter.offsets[1];
				}
			}
		}
		else
		{
			suffix = ' bold';
			if(curLetter != null && curLetter.offsetsBold != null)
			{
				letterOffset[0] = curLetter.offsetsBold[0];
				letterOffset[1] = curLetter.offsetsBold[1];
			}
		}

		var alphaAnim:String = lowercase;
		if(curLetter != null && curLetter.anim != null) alphaAnim = curLetter.anim;

		var anim:String = alphaAnim + suffix;
		animation.addByPrefix(anim, anim, 24);
		animation.play(anim, true);
		if(animation.curAnim == null)
		{
			if(suffix != ' bold') suffix = ' normal';
			anim = 'question' + suffix;
			animation.addByPrefix(anim, anim, 24);
			animation.play(anim, true);
		}
		updateHitbox();
		updateLetterOffset();
	}

	public static function isTypeAlphabet(c:String) // thanks kade
	{
		var ascii = StringTools.fastCodeAt(c, 0);
		return (ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122);
	}

	private function set_image(name:String)
	{
		var lastAnim:String = null;
		if (animation != null)
		{
			lastAnim = animation.name;
		}
		image = name;
		frames = Paths.getSparrowAtlas(name);
		this.scale.x = parent.scaleX;
		this.scale.y = parent.scaleY;
		alignOffset = 0;
		
		if (lastAnim != null)
		{
			animation.addByPrefix(lastAnim, lastAnim, 24);
			animation.play(lastAnim, true);
			
			updateHitbox();
			updateLetterOffset();
		}
		return name;
	}

	public function updateLetterOffset()
	{
		if (animation.curAnim == null) return;

		if(!animation.curAnim.name.endsWith('bold'))
		{
			offset.y += -(110 - height);
		}
	}
}
