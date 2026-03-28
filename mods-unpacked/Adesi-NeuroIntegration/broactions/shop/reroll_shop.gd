extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"
var _button
var _price
func _init(window, button, reroll_value).(window):
	_button = button
	_price = reroll_value
	pass

func _get_name():
	return "reroll_shop"

func _get_description():
	return "rerolls the shop's items, replacing the current items. Locked items will stay even after rerolling. Rerolling costs more each time you reroll" # TODO: better description maybe?

func _get_schema():
	return JsonUtils.wrap_schema({})

func _validate_action(data, state):
	if not is_instance_valid(_button):
		return ExecutionResult.mod_failure("Reroll button doesn't exist for neuro")
	if RunData.get_player_gold(0) < _price:
		return ExecutionResult.failure("Not enough money to reroll the shop")

	return ExecutionResult.success()


func _execute_action(state):
	_button.emit_signal("focus_entered")
	_button.emit_signal("pressed")
