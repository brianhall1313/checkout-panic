extends Node

const debug: bool = true
const item_database:Array[Dictionary]=[{"orange":{"region":Rect2(36,549,23,22),"cost":1},
	"cherry":{"region":Rect2(132,549,18,19),"cost":1},
	"broccoli":{"region":Rect2(68,580,24,22),"cost":1},
	"carrot":{"region":Rect2(331,578,9,29),"cost":1},
	},
	{
	"fish":{"region":Rect2(66,512,25,13),"cost":5},
	"corn":{"region":Rect2(357,581,22,22),"cost":5},
	},
	{
	"tomato":{"region":Rect2(167,583,19,18),"cost":5},
	"cheese":{"region":Rect2(100,522,23,14),"cost":5},
	},
	{
	"bell pepper":{"region":Rect2(358,550,17,19),"cost":5},
	"lettuce":{"region":Rect2(7,582,20,20),"cost":5},
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
		
	
