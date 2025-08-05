extends Node
class_name IntegrationMain
# This file is used to actually faciliate the actions and context management for Neuro,
# This file will be very very very big.
# As i don't want to deal with multiple load() scattered over multiple files. 
# Some dedicated files should be fine. but stuff that interacts with the sdk should be in here. But stuff like a wrapper or something can be written seperatly and included here

var mod_main

var Context = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/messages/outgoing/context.gd")
var ActionWindow = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/action_window.gd")
var NeuroActionHandler
var SelectAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/select_thing.gd")
var InfoAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/get_info.gd")


func _init(parent):
	self.mod_main = parent
	parent.add_child(self)
	

func _ready():
	NeuroActionHandler = get_tree().root.get_node("/root/ModLoader/Adesi-NeuroIntegration/NeuroActionHandlerNode")
	yield (get_tree().create_timer(1), "timeout")
	print("IntegrationMain ready")
	var menu_start_button = get_tree().current_scene.get_node("Menus/MainMenu/%StartButton")
	menu_start_button.emit_signal("pressed")

	yield (get_tree().create_timer(1), "timeout") # wait for character menu to load

	####################### CHARACTER SELECTION ######################
	var character_select = get_tree().current_scene

	var action_window = ActionWindow.new(self)
	action_window.set_force(20, "Select a character you want to play", "", false)
	action_window.add_action(SelectAction.new(action_window, character_select, "character"))

	var characterinfo_action = InfoAction.new(null, character_select, "character_selection")
	NeuroActionHandler.register_actions([characterinfo_action])
	action_window.register()

	while character_select == get_tree().current_scene:
		yield (get_tree().create_timer(0.5), "timeout") # wait for the scene to change

	NeuroActionHandler.unregister_actions([characterinfo_action])


	##################################################################
	####################### WEAPON SELECTION #########################

	var weapon_select = get_tree().current_scene

	var weaponaction_window = ActionWindow.new(self)
	weaponaction_window.set_force(20, "Now please select what weapon you want to start with", "", false)
	weaponaction_window.add_action(SelectAction.new(weaponaction_window, weapon_select, "weapon"))
	var info_action = InfoAction.new(null, weapon_select, "weapon_selection")
	NeuroActionHandler.register_actions([info_action])
	weaponaction_window.register()

	while weapon_select == get_tree().current_scene:
		yield (get_tree().create_timer(0.5), "timeout") # wait for the scene to change
	
	NeuroActionHandler.unregister_actions([info_action])

	#######################################################################
	####################### DIFFICULTY  SELECTION #########################
	var difficulty_select = get_tree().current_scene
	var all_difficulties = difficulty_select._get_unlocked_elements(0)

	if all_difficulties.size() == 1:
		var difficulty_button = difficulty_select._find_inventory_element_by_id(all_difficulties[0], 0)
		difficulty_button.emit_signal("pressed")
	else:
		var difficulty_action_window = ActionWindow.new(self)
		difficulty_action_window.set_force(5, "Select what difficulty you want to play (they are very different!)", "", false)
		difficulty_action_window.add_action(SelectAction.new(difficulty_action_window, difficulty_select, "difficulty"))
		difficulty_action_window.register()
