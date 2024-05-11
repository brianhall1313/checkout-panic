extends Node

const debug: bool = true
const item_database:Array[Dictionary]=[{"orange":{"region":Rect2(36,549,23,22),"cost":1},
	"cherry":{"region":Rect2(132,549,18,19),"cost":1},
	"broccoli":{"region":Rect2(68,580,24,22),"cost":1},
	"carrot":{"region":Rect2(331,578,9,29),"cost":1},
	},
	]


var items: Dictionary={} 

func initialize_items(intensity):
	items = {}
	for level in range(intensity):
		for item in item_database[level].keys():
			items[item]=item_database[level][item].duplicate()

func get_random_item():
	return items.keys().pick_random()

func get_shoping_list():
	var list:Array=[]
	for item in items.keys():
		list.append({"item_name":item,"have":0,"need":randi_range(1*Global.intensity,4*Global.intensity)})
	return list
		
	
