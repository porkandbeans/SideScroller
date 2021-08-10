package;

//import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
//import flixel.text.FlxText;
//import flixel.input.mouse.FlxMouse;

class PlayState extends FlxState
{
	//var text:FlxText;
	var _map:FlxOgmo3Loader;
	var _tilemap:FlxTilemap;
	var _player:Player;
	var _hud:HUD;
	
	override public function create()
	{
		_map = new FlxOgmo3Loader(
			"assets/levels/hworld.ogmo", 
			"assets/levels/level1.json");
		_tilemap = _map.loadTilemap("assets/data/tilewall.png", "walls");
		_tilemap.follow();
		_tilemap.setTileProperties(1, FlxObject.NONE);
		_tilemap.setTileProperties(2, FlxObject.ANY);
		add(_tilemap);

		/*	text = new FlxText(0,0,0, "doing chores", 32);
			text.screenCenter();
			add(text); */

		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		
		_hud = new HUD();
		add(_hud);

		super.create();
	}

	function placeEntities(entity:EntityData){
		if(entity.name == "player"){
			_player.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		_hud.updateBar(_player.floatyPower); // gets the floating juice left in the player, sends it to the HUD
		collisions();

		FlxG.camera.follow(_player, PLATFORMER, 1);

		super.update(elapsed);
	}

	function collisions()
	{
		FlxG.collide(_tilemap, _player);
	}
}