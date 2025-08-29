extends "res://ui/menus/run/weapon_selection.gd"

func _ready():
	._ready()

	var weaponaction_window = Utils.ActionWindow.new(self)
	weaponaction_window.set_context("Now please select what weapon you want to start with", false)
	weaponaction_window.add_action(Utils.SelectAction.new(weaponaction_window, self, "weapon"))
	weaponaction_window.add_action(Utils.InfoAction.new(null, self, "weapon"))
	weaponaction_window.register()


func _exit_tree():
	Utils.Context.send("You've selected a weapon. Now its time to select a difficulty")