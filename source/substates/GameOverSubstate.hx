package substates;


import GameOverSubstate as OG_GameOverSubstate;

class GameOverSubstate
{
	@:isVar public static var characterName(get, set):String; // = 'bf-dead';
	static function get_characterName() { return OG_GameOverSubstate.characterName;}
	static function set_characterName(input:String) { 
		OG_GameOverSubstate.characterName = input; return OG_GameOverSubstate.characterName;
	}
	
	@:isVar public static var deathSoundName(get, set):String; //= 'fnf_loss_sfx';
	static function get_deathSoundName() { return OG_GameOverSubstate.deathSoundName;}
	static function set_deathSoundName(input:String) { 
		OG_GameOverSubstate.deathSoundName = input; return OG_GameOverSubstate.deathSoundName;
	}
	
	@:isVar public static var loopSoundName(get, set):String; // = 'gameOver';
	static function get_loopSoundName() { return OG_GameOverSubstate.loopSoundName;}
	static function set_loopSoundName(input:String) { 
		OG_GameOverSubstate.loopSoundName = input; return OG_GameOverSubstate.loopSoundName;
	}
	
	@:isVar public static var endSoundName(get, set):String; //= 'gameOverEnd';
	static function get_endSoundName() { return OG_GameOverSubstate.endSoundName;}
	static function set_endSoundName(input:String) { 
		OG_GameOverSubstate.endSoundName = input; return OG_GameOverSubstate.endSoundName;
	}

	@:isVar public static var instance(get, null):OG_GameOverSubstate;
	static function get_instance() { return OG_GameOverSubstate.instance;}
	
	
	public function new(x:Float, y:Float){}
}
