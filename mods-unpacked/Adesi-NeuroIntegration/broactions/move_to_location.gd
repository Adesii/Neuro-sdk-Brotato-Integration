class_name MoveTo
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

func _init(window).(window):
	pass

func _get_name():
	return "move_to_location"

func _get_description():
	return "Select a Location to move to. Should be somewhere between %s and %s in either direction" % [ZoneService.current_zone_min_position, ZoneService.current_zone_max_position]

func _get_schema():
	var json_string = JsonUtils.wrap_schema({
		"move_to_target": {
			"type": "object",
			"properties": {
				"x": {"type": "number", "minimum": 0, "maximum": ZoneService.current_zone_max_position.x},
				"y": {"type": "number", "minimum": 0, "maximum": ZoneService.current_zone_max_position.y}
			}
		}
	})

	return json_string

func _validate_action(data, state):
	if not data._data.has("move_to_target"):
		return ExecutionResult.failure(Strings.action_failed_missing_required_parameter(["move_to_target"]))
	print(data)
	if not data._data.get("move_to_target").has("x") or not data._data.get("move_to_target").has("y"):
		return ExecutionResult.failure(Strings.action_failed_invalid_parameter(["move_to_target"]))
	var x = data._data.get("move_to_target").get("x", 0.0)
	var y = data._data.get("move_to_target").get("y", 0.0)
	state["MoveTo"] = Vector2(x, y)
	state["move_type"] = Utils.MoveMode.MoveTo
	return ExecutionResult.success()


func _execute_action(state):
	Utils.move_mode = state["move_type"]
	Utils.move_to_target = state["MoveTo"]
