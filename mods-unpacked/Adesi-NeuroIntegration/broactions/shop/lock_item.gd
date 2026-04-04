extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

var shopItems
func _init(item).(null):
	shopItems = item

func _get_name():
	return "lock_item"

func _get_description():
	return "toggle the Lock on a certain item in the shop, This item will stay in the shop between rounds and when rerolling the shop if locked"

func _get_schema():
	return JsonUtils.wrap_schema({
		"item": {
			"enum": get_item_names()
		}
	})

func _validate_action(data, state):
	var selected = data.get_string("item", "")
	if not selected or selected == "":
		return ExecutionResult.failure(Strings.action_failed_missing_required_parameter(["item"]))

	var available = get_item_names()
	if not available.has(selected):
		return ExecutionResult.failure(Strings.action_failed_invalid_parameter(["item"]))
	var item_name = selected
	for item in shopItems:
		if item.item_data.get_name_text() == item_name:
			state["item"] = item
			if item.locked:
				return ExecutionResult.success("Unlocked Item: %s" %item_name)
			return ExecutionResult.success("Locked Item: %s" % item_name)

	return ExecutionResult.mod_failure("Couldn't find item even tho it is available")


func _execute_action(state):
	var item = state["item"]
	item._lock_button.emit_signal("toggled",!item.locked)


func get_item_names():
	var final_selection = []
	for item in shopItems:
		final_selection.append(item.item_data.get_name_text())
	return final_selection
