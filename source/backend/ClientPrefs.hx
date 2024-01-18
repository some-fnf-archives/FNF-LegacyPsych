package backend;
import ClientPrefs as OG_ClientPrefs;
import flixel.FlxG;
class ClientPrefs {
	//backporting 0.7.1 scripts to 0.6.3 with a singleton lol
	public static final data:ClientPrefs = new ClientPrefs();
	
	@:isVar public var downScroll(get, set):Bool;
	@:isVar public var middleScroll(get, set):Bool;
	@:isVar public var opponentStrums(get, set):Bool;
	@:isVar public var showFPS(get, set):Bool;
	@:isVar public var flashing(get, set):Bool;
	@:isVar public var autoPause(get, set):Bool;
	@:isVar public var antialiasing(get, set):Bool;
	@:isVar public var noteSkin(get, set):String;
	@:isVar public var splashSkin(get, set):String;
	@:isVar public var splashAlpha(get, set):Float;
	@:isVar public var lowQuality(get, set):Bool;// = false;
	@:isVar public var shaders(get, set):Bool;// = true;
	@:isVar public var cacheOnGPU(get, set):Bool = #if !switch false #else true #end; //From Stilic
	@:isVar public var framerate(get, set):Int;// = 60;
	@:isVar public var camZooms(get, set):Bool;// = true;
	@:isVar public var hideHud(get, set):Bool;// = false;
	@:isVar public var noteOffset(get, set):Int;// = 0;
	@:isVar public var ghostTapping(get, set):Bool;// = true;
	@:isVar public var timeBarType(get, set):String;// = 'Time Left';
	@:isVar public var scoreZoom(get, set):Bool;// = true;
	@:isVar public var noReset(get, set):Bool;// = false;
	@:isVar public var healthBarAlpha(get, set):Float;// = 1;
	@:isVar public var hitsoundVolume(get, set):Float;// = 0;
	@:isVar public var pauseMusic(get, set):String;// = 'Tea Time';
	@:isVar public var checkForUpdates(get, set):Bool;// = true;
	@:isVar public var comboStacking(get, set):Bool;// = true;
	/*@:isVar public var gameplaySettings(get, set):Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		// -kade
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];*/

	@:isVar public var comboOffset(get, set):Array<Int>;// = [0, 0, 0, 0];
	@:isVar public var ratingOffset(get, set):Int;// = 0;
	@:isVar public var sickWindow(get, set):Float;// = 45;
	@:isVar public var goodWindow(get, set):Float;// = 90;
	@:isVar public var badWindow(get, set):Float;// = 135;
	@:isVar public var safeFrames(get, set):Float;// = 10;
	@:isVar public var discordRPC(get, set):Bool;// = true;

	//These are not yet supported
	function get_splashSkin() { return "";/*OG_ClientPrefs.data.splashSkin;*/}
	function set_splashSkin(input:String) {  return "";/*OG_ClientPrefs.data.splashSkin = input;*/}
		
	function get_splashAlpha() { return 0.6; /*OG_ClientPrefs.data.splashAlpha;*/}
	function set_splashAlpha(input:Float) {return 0.6; /*OG_ClientPrefs.data.splashAlpha = input;*/}

	function get_cacheOnGPU() { return false; /*OG_ClientPrefs.data.cacheOnGPU*/}
	function set_cacheOnGPU(input:Bool) {return false;/* OG_ClientPrefs.data.cacheOnGPU = input;*/}

	function get_noteSkin() { return "Default"; /*OG_ClientPrefs.data.noteSkin;*/}
	function set_noteSkin(input:String) { return "Default"; /*OG_ClientPrefs.data.noteSkin = input*/}

	function get_discordRPC() { return true;} //OG_ClientPrefs.data.discordRPC;}
	function set_discordRPC(input:Bool) {return true; }//OG_ClientPrefs.data.discordRPC = input;}

	//These are work-arounds
	function get_autoPause() { return FlxG.autoPause;}
	function set_autoPause(input:Bool) { FlxG.autoPause = input; return FlxG.autoPause;}
	
	function get_antialiasing() { return OG_ClientPrefs.data.globalAntialiasing;}
	function set_antialiasing(input:Bool) { OG_ClientPrefs.data.globalAntialiasing = input; return OG_ClientPrefs.data.globalAntialiasing;}

	function get_downScroll() { return OG_ClientPrefs.data.downScroll;}
	function set_downScroll(input:Bool) { OG_ClientPrefs.data.downScroll = input; return OG_ClientPrefs.data.downScroll;}
	function get_middleScroll() { return OG_ClientPrefs.data.middleScroll;}
	function set_middleScroll(input:Bool) { OG_ClientPrefs.data.middleScroll = input; return OG_ClientPrefs.data.middleScroll;}
	function get_opponentStrums() { return OG_ClientPrefs.data.opponentStrums;}
	function set_opponentStrums(input:Bool) { OG_ClientPrefs.data.opponentStrums = input; return OG_ClientPrefs.data.opponentStrums;}
	function get_showFPS() { return OG_ClientPrefs.data.showFPS;}
	function set_showFPS(input:Bool) { OG_ClientPrefs.data.showFPS = input; return OG_ClientPrefs.data.showFPS;}
	function get_flashing() { return OG_ClientPrefs.data.flashing;}
	function set_flashing(input:Bool) { OG_ClientPrefs.data.flashing = input; return OG_ClientPrefs.data.flashing;}

	function get_lowQuality() { return OG_ClientPrefs.data.lowQuality;}
	function set_lowQuality(input:Bool) { OG_ClientPrefs.data.lowQuality = input; return OG_ClientPrefs.data.lowQuality;}
	function get_shaders() { return OG_ClientPrefs.data.shaders;}
	function set_shaders(input:Bool) { OG_ClientPrefs.data.shaders = input; return OG_ClientPrefs.data.shaders;}

	function get_framerate() { return OG_ClientPrefs.data.framerate;}
	function set_framerate(input:Int) { OG_ClientPrefs.data.framerate = input; return OG_ClientPrefs.data.framerate;}
	function get_camZooms() { return OG_ClientPrefs.data.camZooms;}
	function set_camZooms(input:Bool) { OG_ClientPrefs.data.camZooms = input; return OG_ClientPrefs.data.camZooms;}
	function get_hideHud() { return OG_ClientPrefs.data.hideHud;}
	function set_hideHud(input:Bool) { OG_ClientPrefs.data.hideHud = input; return OG_ClientPrefs.data.hideHud;}
	function get_noteOffset() { return OG_ClientPrefs.data.noteOffset;}
	function set_noteOffset(input:Int) { OG_ClientPrefs.data.noteOffset = input; return OG_ClientPrefs.data.noteOffset;}
	function get_ghostTapping() { return OG_ClientPrefs.data.ghostTapping;}
	function set_ghostTapping(input:Bool) { OG_ClientPrefs.data.ghostTapping = input; return OG_ClientPrefs.data.ghostTapping;}
	function get_timeBarType() { return OG_ClientPrefs.data.timeBarType;}
	function set_timeBarType(input:String) { OG_ClientPrefs.data.timeBarType = input; return OG_ClientPrefs.data.timeBarType;}
	function get_scoreZoom() { return OG_ClientPrefs.data.scoreZoom;}
	function set_scoreZoom(input:Bool) { OG_ClientPrefs.data.scoreZoom = input; return OG_ClientPrefs.data.scoreZoom;}
	function get_noReset() { return OG_ClientPrefs.data.noReset;}
	function set_noReset(input:Bool) { OG_ClientPrefs.data.noReset = input; return OG_ClientPrefs.data.noReset;}
	function get_healthBarAlpha() { return OG_ClientPrefs.data.healthBarAlpha;}
	function set_healthBarAlpha(input:Float) { OG_ClientPrefs.data.healthBarAlpha = input; return OG_ClientPrefs.data.healthBarAlpha;}
	function get_hitsoundVolume() { return OG_ClientPrefs.data.hitsoundVolume;}
	function set_hitsoundVolume(input:Float) { OG_ClientPrefs.data.hitsoundVolume = input; return OG_ClientPrefs.data.hitsoundVolume;}
	function get_pauseMusic() { return OG_ClientPrefs.data.pauseMusic;}
	function set_pauseMusic(input:String) { OG_ClientPrefs.data.pauseMusic = input; return OG_ClientPrefs.data.pauseMusic;}
	function get_checkForUpdates() { return OG_ClientPrefs.data.checkForUpdates;}
	function set_checkForUpdates(input:Bool) { OG_ClientPrefs.data.checkForUpdates = input; return OG_ClientPrefs.data.checkForUpdates;}
	function get_comboStacking() { return OG_ClientPrefs.data.comboStacking;}
	function set_comboStacking(input:Bool) { OG_ClientPrefs.data.comboStacking = input; return OG_ClientPrefs.data.comboStacking;}
	function get_comboOffset() { return OG_ClientPrefs.data.comboOffset;}
	function set_comboOffset(input:Array<Int>) { OG_ClientPrefs.data.comboOffset = input; return OG_ClientPrefs.data.comboOffset;}
	function get_ratingOffset():Int { return OG_ClientPrefs.data.ratingOffset;}
	function set_ratingOffset(input:Int) { OG_ClientPrefs.data.ratingOffset = input; return OG_ClientPrefs.data.ratingOffset;}
	function get_sickWindow():Float { return OG_ClientPrefs.data.sickWindow;}
	function set_sickWindow(input:Float) { OG_ClientPrefs.data.sickWindow = input; return OG_ClientPrefs.data.sickWindow;}
	function get_goodWindow():Float { return OG_ClientPrefs.data.goodWindow;}
	function set_goodWindow(input:Float) { OG_ClientPrefs.data.goodWindow = input; return OG_ClientPrefs.data.goodWindow;}
	function get_badWindow():Float { return OG_ClientPrefs.data.badWindow;}
	function set_badWindow(input:Float) { OG_ClientPrefs.data.badWindow = input; return OG_ClientPrefs.data.badWindow;}
	function get_safeFrames():Float { return OG_ClientPrefs.data.safeFrames;}
	function set_safeFrames(input:Float) { OG_ClientPrefs.data.safeFrames = input; return OG_ClientPrefs.data.safeFrames;}


	private function new(){}
}
