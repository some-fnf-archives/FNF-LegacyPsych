package substates;

import PauseSubState as OG_PauseSubState;

class PauseSubState
{
	@:isVar public static var songName(get, set):String;
	static function get_songName() { return OG_PauseSubState.songName;}
	static function set_songName(input:String) { 
		OG_PauseSubState.songName = input; return OG_PauseSubState.songName;
	}
	
	public function new(x:Float, y:Float){}
}
