extends "res://ui/menus/run/difficulty_selection/difficulty_selection.gd"

func _ready():
	._ready()

	
	var all_difficulties = _get_unlocked_elements(0)

	if all_difficulties.size() == 1:
		var difficulty_button = _find_inventory_element_by_id(all_difficulties[0], 0)
		difficulty_button.emit_signal("pressed")
	else:
		var difficulty_action_window = Utils.ActionWindow.new(self)
		difficulty_action_window.set_force(5, "Select what difficulty you want to play (they are very different!)", "", false)
		difficulty_action_window.add_action(Utils.SelectAction.new(difficulty_action_window, self, "difficulty"))
		difficulty_action_window.register()
	

func _exit_tree():
	Utils.Context.send("Difficulty Selected. You are now playing Brotato!")