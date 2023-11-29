package;

class Rating
{
	public var name:String = '';
	public var image:String = '';
	public var counter:String = '';
	public var hitWindow:Null<Int> = 0; //ms
	public var ratingMod:Float = 1;
	public var score:Int = 350;
	public var noteSplash:Bool = true;

	public function new(name:String)
	{
		this.name = name;
		this.image = name;
		this.counter = name + 's';
		this.hitWindow = Reflect.field(ClientPrefs.data, name + 'Window');
		if(hitWindow == null)
		{
			hitWindow = 0;
		}
	}

	public function increase(blah:Int = 1)
	{
		Reflect.setField(PlayState.instance, counter, Reflect.field(PlayState.instance, counter) + blah);
	}

	public static inline function getDefaultList():Array<Rating> {
		final good:Rating = new Rating('good');
		final bad:Rating = new Rating('bad');
		final shit:Rating = new Rating('shit');

		good.ratingMod = 0.7;
		bad.ratingMod = 0.4;
		shit.ratingMod = 0;

		good.score = 200;
		bad.score = 100;
		shit.score = 50;

		good.noteSplash = false;
		bad.noteSplash = false;
		shit.noteSplash = false;

		return [new Rating('sick'), good, bad, shit];
	}
}
