class_name Player
extends Resource
#how much you can spend,how much you have spent
@export var budget:int
@export var spent: int
#number of credit cards you have
const new_game_cards:int = 2
@export var cards:int =0
#credit card spending limit,credit you currently have
@export var credit_limit:int = 3
@export var credit_current:int = 0
#total debt from all cards
@export var debt:int=0

@export var list: Array

func game_setup(data={}):
	if data:
		cards=data["cards"]
	else:
		cards = new_game_cards
	list = Items.get_shoping_list()
	GlobalSignalBus.update_list.emit(list)
	set_budget()


func set_budget():
	budget = 0
	for item in list:
		budget += item["need"] * Items.items[item["item_name"]]["cost"]
	print(budget," is our budget")

func bought(item:String):
	list_management(item)
	var overage:int = 0
	var cost:int=Items.items[item]["cost"]
	if spent < budget:
		if cost<=budget-spent:
			spent += cost
			return
		elif cards>0:
			overage = spent+cost-budget
			spent=budget
			expense(overage)
		else:
			#this is just in case you should never get here.
			GlobalSignalBus.game_over.emit()
	else:
		overage = cost
		expense(overage)


func expense(cost:int):
	var overage:int = 0
	if cards>=1:
		if credit_current+cost<=credit_limit:
			credit_current+=cost
			return
		else:
			if cards==1:
				debt += credit_current+cost
				GlobalSignalBus.game_over.emit(debt)
				return
		overage = credit_current + cost - credit_limit
		debt += credit_limit
		# nothing should be able to on shot you so this should be safe
		cards -= 1
		credit_current = 0 + overage
	else:
		debt += cost
		GlobalSignalBus.game_over.emit(debt)


func list_management(item):
	for list_item in list:
		if list_item.item_name == item:
			list_item["have"] += 1
			if list_item["have"] >= list_item["need"]:
				check_complete()
	GlobalSignalBus.update_list.emit(list)


func check_complete():
	for item in list:
		if item["have"]<item["need"]:
			return
	GlobalSignalBus.list_complete.emit()


