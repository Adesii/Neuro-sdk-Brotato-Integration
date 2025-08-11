extends "res://ui/menus/run/weapon_selection.gd"

var info_action
func _ready():
	._ready()

	
	var weaponaction_window = Utils.ActionWindow.new(self)
	weaponaction_window.set_force(60, "Now please select what weapon you want to start with", "You are in the Weapon selection menu. about to select a weapon for your character")
	weaponaction_window.add_action(Utils.SelectAction.new(weaponaction_window, self, "weapon"))
	info_action = Utils.InfoAction.new(null, self, "weapon")
	Utils.NeuroActionHandler.register_actions([info_action])
	weaponaction_window.register()


func _exit_tree():
	Utils.NeuroActionHandler.unregister_actions([info_action])

	Utils.Context.send("You've selected a weapon. Now its time to select a difficulty")