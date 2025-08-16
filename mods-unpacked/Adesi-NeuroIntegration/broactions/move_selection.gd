class_name MoveAction
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

var name_array := ["KeepDistance",
	"RunToClosestEnemy",
    "",
    "Circle",
    "Random",
    "Idle"]

func _init(window).(window):
	pass

func _get_name():
	return "move_type"

func _get_description():
	return "Select a move pattern, you should vary your selection and change them from time to time during gameplay. Or use Movement options that compliment your build, custom_move_target only is needed when using the MoveTo enum. otherwise its ignored"

func _get_schema():
	var json_string = JsonUtils.wrap_schema({
		"move_type": {
			"enum": name_array
		}
	})
	return json_string

func _validate_action(data, state):
	var selected = data.get_string("move_type", "")
	if not selected or selected == "":
		return ExecutionResult.failure(Strings.action_failed_missing_required_parameter(["move_type"]))
	
	var available = name_array
	if not available.has(selected):
		return ExecutionResult.failure(Strings.action_failed_invalid_parameter(["move_type"]))

	state["move_type"] = name_array.find(selected)
	return ExecutionResult.success()


func _execute_action(state):
	Utils.move_mode = state["move_type"]
