-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop 
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO 
import Graphics.X11.ExtraTypes.XF86  
import XMonad.Util.EZConfig 

main = do
xmproc <- spawnPipe "xmobar"   

xmonad $ defaultConfig
	{manageHook = manageDocks <+> manageHook defaultConfig  
	, layoutHook = avoidStruts $ layoutHook defaultConfig  
	, logHook = dynamicLogWithPP xmobarPP  
           { ppOutput = hPutStrLn xmproc  
           , ppTitle = xmobarColor "blue" "" . shorten 50   
           , ppLayout = const "" -- to disable the layout info on xmobar  
           }
	, modMask = mod4Mask
	, terminal = "urxvt256c"
	} 
	`additionalKeys`  
	[((0, xF86XK_MonBrightnessUp), spawn "xbacklight +10")]	  
	`additionalKeys`  
	[((0, xF86XK_MonBrightnessDown), spawn "xbacklight -10")]	  
	`additionalKeys`  
	[((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master playback 5%+")]	  
	`additionalKeys`  
	[((0, xF86XK_AudioLowerVolume), spawn "amixer set Master playback 5%-")]	  
	`additionalKeys`  
	[((0, xF86XK_AudioMute), spawn "amixer set Master toggle")]	  
