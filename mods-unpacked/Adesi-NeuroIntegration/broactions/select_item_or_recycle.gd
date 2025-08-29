class_name SelectItemOrRecycle
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/neuro_action.gd"

var selection_item
var _take_button
var _discard_button
func _init(window, item, take_button, discard_button).(window):
	selection_item = item
	_take_button = take_button
	_discard_button = discard_button


func _get_name():
	return "keep_item_or_recycle"

func _get_description():
	return "you picked up an item during the wave, you can now decide to keep it and gain its effects or recycle it to get more money instead, %s" % [get_item_details()]

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
	var button_action = ""
	if ("Take" in selected):
		button_action = "Take"
	elif ("Recycle" in selected):
		button_action = "Recycle"
	state["item"] = find_item_button(selected, button_action)
	if (state["item"] == null):
		return ExecutionResult.mod_failure("couldn't find the button for %s to press..." % [button_action])
	return ExecutionResult.success()


func _execute_action(state):
	state["item"].emit_signal("pressed")


func get_item_names():
	var final_selection = []
	final_selection.append("Take %s" % [selection_item.get_name_text()])
	final_selection.append("Recycle %s for %s" % [selection_item.get_name_text(), str(ItemService.get_recycling_value(RunData.current_wave, selection_item.value, 0, selection_item is WeaponData))])
	return final_selection

func get_item_details():
	var final_string = ""
	final_string += "name:\n"
	final_string += str(selection_item.get_name_text())
	final_string += "\ndescription:\n"
	final_string += str(selection_item.get_effects_text(0))
	#var regexr = RegEx.new()
	#regexr.compile("\\[.*?\\]") # this is a regex to remove all color info and image paths from the text.  [Color] or res://****.png

	#final_string = regexr.sub(final_string, "", true)

	final_string = final_string.replace("res://items/stats/", " ")
	final_string = final_string.replace(".png", ", ")
	return final_string

func find_item_button(translated_name, action):
	if (action == "Take"):
		return _take_button
	elif (action == "Recycle"):
		return _discard_button
	return null