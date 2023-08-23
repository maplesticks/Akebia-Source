package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class GameOver extends MusicBeatSubstate
{
    public var gameOverText:FlxText;
    public var gameOverSubText:FlxText;

	public function new(x:Float, y:Float)
	{
		super();
       
        PlayState.instance.setOnLuas('inGameOver', true);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 1;
		bg.scrollFactor.set();
		add(bg);

	    gameOverText = new FlxText(20, 500, 0, "Game Over", 32);
		gameOverText.scrollFactor.set();
        gameOverText.screenCenter(X);
		gameOverText.setFormat(Paths.font("vcr.ttf"), 32);
		gameOverText.updateHitbox();
		add(gameOverText);

        gameOverSubText = new FlxText(20, 525, 0, "Press the Enter key to restart.", 32);
		gameOverSubText.scrollFactor.set();
        gameOverSubText.screenCenter(X);
		gameOverSubText.setFormat(Paths.font("vcr.ttf"), 32);
		gameOverSubText.updateHitbox();
		add(gameOverSubText);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

	if (controls.ACCEPT)
		{
            MusicBeatState.resetState();
            gameOverText.alpha = 0;
            gameOverSubText.alpha = 0;
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			WeekData.loadTheFirstEnabledMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new MainMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

	}
}