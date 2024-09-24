extends Node

var intensity:int = 1
var state:String="new"
var states:Array[String]=["menu","new","continue","pregame","play","game over"]

var data = {}


func save(new_data):
	data=new_data 

func load_data():
	return data

func change_state(new_state:String):
	if states.has(new_state):
		state = new_state
	else:
		print("not a state")
