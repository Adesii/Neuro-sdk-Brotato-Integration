extends "res://main.gd"

var MoveAction = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/main_stage/move_selection.gd")
var MoveLocationAction = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/main_stage/move_to_location.gd")

var move_action
var move_to_action
func _enter_tree():
	yield (get_tree().create_timer(0.3), "timeout")
	move_action = MoveAction.new(null)
	move_to_action = MoveLocationAction.new(null)
	Utils.NeuroActionHandler.register_actions([move_action, move_to_action])


var seconds = 0.0
var unregistered_actions := false

func _physics_process(delta):
	._physics_process(delta)

	seconds += delta
	if seconds >= 5.0:
		seconds = 0.0
		Context.send("Your current position: %s, Your current Health: %s, Current Enemy Count: %s" % [_players[0].global_position, RunData.get_player_current_health(0), RunData.current_living_enemies], true)

func clean_up_room():
    .clean_up_room()
    _exit_tree()

func _exit_tree():
    if not unregistered_actions:
        Utils.NeuroActionHandler.unregister_actions([move_action, move_to_action])
        unregistered_actions = true
