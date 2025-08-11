extends Node
class_name IntegrationMain
# This file is used to actually faciliate the actions and context management for Neuro,
# This file will be very very very big.
# As i don't want to deal with multiple load() scattered over multiple files. 
# Some dedicated files should be fine. but stuff that interacts with the sdk should be in here. But stuff like a wrapper or something can be written seperatly and included here

var mod_main


func _init(parent):
	self.mod_main = parent
	parent.add_child(self)
	

func _ready():
	yield (get_tree().create_timer(1), "timeout")
	print("IntegrationMain ready")
	var menu_start_button = get_tree().current_scene.get_node("Menus/MainMenu/%StartButton")
	menu_start_button.emit_signal("pressed")
