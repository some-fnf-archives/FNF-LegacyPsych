#if !macro
//Discord API
#if DISCORD_ALLOWED
import Discord;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if ACHIEVEMENTS_ALLOWED
import Achievements;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import Paths;
import Controls;
import CoolUtil;
import MusicBeatState;
import MusicBeatSubstate;
import CustomFadeTransition;
import ClientPrefs;
import Conductor;

import Alphabet;
import BGSprite;

import PlayState;
import LoadingState;

#if flxanimate
import flxanimate.*;
#end

//Flixel
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;
#end
