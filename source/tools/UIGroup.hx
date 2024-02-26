package tools;

import openfl.display.BitmapData;
import openfl.display.BlendMode;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxFrame;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup.FlxTypedGroupIterator;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSort;

class UIGroup extends FlxBasic
{
	public var onAdd:( Dynamic ->Void );
	public var members:Array<Dynamic>;
	public var x:Float = 0;
	public var y:Float = 0;
	public var groupName:String = "";
	
	//If I knew a better way to do this I would but I simply just hate FlxGroups this much
	
	override function set_cameras(Value:Array<FlxCamera>):Array<FlxCamera>
	{
		for(spr in members){
			try{
				var t = cast(spr, FlxTypedGroup<Dynamic>);
				for(spr in t.members){
					setCams(spr, cameras);
				}	
			}
			catch(err){}
			
			setCams(spr, cameras);
		}
		return _cameras = Value;
	}
	
	/**
	 * @param   X         The initial X position of the group.
	 * @param   Y         The initial Y position of the group.
	 * @param   MaxSize   Maximum amount of members allowed.
	 */
	public function new()
	{
		super();
		members = [];
	}
	
	public function add(Sprite:Dynamic):Dynamic
	{
		preAdd(Sprite);
		onAdd(Sprite);
		members.push(Sprite);
		return Sprite;
	}

	public function remove(Sprite:Dynamic, ?Splice:Bool = false)
	{
		try{
			var spr = cast(Sprite,FlxBasic);
			spr.cameras = null;
			
			var spr = cast(Sprite,FlxSprite);
			spr.x -= x;
			spr.y -= y;
			
		}
		catch(err){
			//we're about to get rid of this thing anyways it doesn't matter
		}
		return members.remove(Sprite);
	}
	
	public function setCams(Sprite:Dynamic, cams:Array<FlxCamera>)
	{
		try{
			try{
				var t = cast(Sprite, FlxTypedGroup<Dynamic>);
				for(spr in t.members){
					setCams(spr, cameras);
				}	
			}
			catch(err){}
			var spr = cast(Sprite,FlxBasic);
			spr.cameras = cams;
		}
		catch(err){
			trace(err);
			trace('error setting cameras on object in group $groupName');
		}
	}
	
	
	
	public function preAdd(Sprite:Dynamic)
	{
		try{
			var spr = cast(Sprite,FlxSprite);
			spr.x += x;
			spr.y += y;
		}
		catch(err){
			
		}
		setCams(Sprite, cameras);
	}
	
	
	
}
