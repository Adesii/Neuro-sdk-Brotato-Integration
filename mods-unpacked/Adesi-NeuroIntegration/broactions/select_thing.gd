class_name SelectAction
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

var selection_basis # thing should inherit BaseSelection
var what_is_being_selected

var cached_names = []
func _init(window, basis, what).(window):
	selection_basis = basis
	what_is_being_selected = what

func _get_name():
	return "choose_" + what_is_being_selected

func _get_description():
	return "Choses an {what_is_being_selected} from the list."

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
	state["item"] = find_item_button(selected)
	return ExecutionResult.success()


func _execute_action(state):
	state["item"].emit_signal("pressed")


func get_item_names():
	var names = []
	if cached_names.empty():
		for item in selection_basis._get_unlocked_elements(0):
			names.append(selection_basis._find_inventory_element_by_id(item, 0).item.get_name_text())
		cached_names = names
		return cached_names
	else:
		return cached_names


func find_item_button(translated_name):
	for item in selection_basis._get_unlocked_elements(0):
		#names_and_ids.append({"name": selection_basis._find_inventory_element_by_id(item, 0).item.get_name_text(), "id": item})
		var button = selection_basis._find_inventory_element_by_id(item, 0)
		var name = button.item.get_name_text()
		if name == translated_name:
			return button
	return null