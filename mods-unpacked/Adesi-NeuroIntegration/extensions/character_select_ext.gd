extends "res://ui/menus/run/character_selection.gd"


var characterinfo_action

func _ready():
	._ready()
	Utils.Context.send("Its time to select a character you want to play. each Character has Unique statitics that can be used to guide your playstyle.", true)

	var action_window = Utils.ActionWindow.new(self)
	action_window.set_force(60, "Select a character you want to play", "You are in the Character selection menu. about to select a character")
	action_window.add_action(Utils.SelectAction.new(action_window, self, "character"))

	characterinfo_action = Utils.InfoAction.new(null, self, "character")
	Utils.NeuroActionHandler.register_actions([characterinfo_action])
	action_window.register()

func _exit_tree():
	Utils.NeuroActionHandler.unregister_actions([characterinfo_action])
	Utils.Context.send("You've selected a character. Now its time to select a Weapon to use with the character.  each Weapon has Unique statitics that can be used to guide your playstyle.", true)
