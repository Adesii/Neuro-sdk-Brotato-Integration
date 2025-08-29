class_name SelectUpgrade
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

var selection_arr # thing should inherit BaseSelection

var cached_names = []
func _init(window, arr).(window):
	selection_arr = arr

func _get_name():
	return "choose_upgrade"

func _get_description():
	return "Choses an upgrade from the list. the options include: %s" % [get_item_details()]

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
		for item in selection_arr:
			names.append(item.upgrade_data.get_name_text())
		cached_names = names
		return cached_names
	else:
		return cached_names

func get_item_details():
	var final_string = ""
	for item in selection_arr:
		final_string += "[ name:"
		final_string += str(item.upgrade_data.get_name_text())
		final_string += ",description"
		final_string += str(item.upgrade_data.get_effects_text(0))
		final_string += "]"
	#var regexr = RegEx.new()
	#regexr.compile("\\[.*?\\]") # this is a to remove all color info and image paths from the text.  [Color] or res://****.png

	#final_string = regexr.sub(final_string, "", true)

	final_string = final_string.replace("res://items/stats/", " ")
	final_string = final_string.replace(".png", ", ")
	return final_string

func find_item_button(translated_name):
	for item in selection_arr:
		#names_and_ids.append({"name": selection_arr._find_inventory_element_by_id(item, 0).item.get_name_text(), "id": item})
		var button = item.button
		var name = item.upgrade_data.get_name_text()
		if name == translated_name:
			return button
	return null