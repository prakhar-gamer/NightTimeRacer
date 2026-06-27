extends Node

signal Crashed
signal Restart
signal Pause(screen: bool)
signal Unpause


var Points = 0
var BestRun = 0
var pauseState = false
