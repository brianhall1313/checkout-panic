extends Node

var intensity:int = 1

var state:String="menu"
var states:Array[String]=["menu","pregame","play","game over"]

func change_state(new_state:String):
	if states.has(new_state):
		state = new_state
	else:
		print("not a state")
