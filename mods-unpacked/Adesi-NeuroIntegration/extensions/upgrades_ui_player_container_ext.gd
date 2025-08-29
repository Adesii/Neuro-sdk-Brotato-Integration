extends "res://ui/menus/ingame/upgrades_ui_player_container.gd"


func show_item(item_data: ItemParentData) -> void:
	.show_item(item_data)

	#TODO: register correct actions and selection data
	print("showing item " + str(item_data))
	var action_window = Utils.ActionWindow.new(self)
	action_window.set_force(5, "Choose to keep the item or recycle it", "")
	action_window.add_action(load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/select_item_or_recycle.gd").new(action_window, item_data, _take_button, _discard_button))
	action_window.register()

func show_upgrades_for_level(level: int) -> void:
	.show_upgrades_for_level(level)

	#TODO: register correct actions and selection data

	print("showing upgrade for level " + str(level))

	var update_uis = _get_upgrade_uis()
	var action_window = Utils.ActionWindow.new(self)
	action_window.set_force(5, "Choose an Upgrade from the list of available ones to add to your character. these persist for the current run", "")
	var select_upgrade_action = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/select_upgrade.gd")
	action_window.add_action(select_upgrade_action.new(action_window, update_uis))
	action_window.register()
