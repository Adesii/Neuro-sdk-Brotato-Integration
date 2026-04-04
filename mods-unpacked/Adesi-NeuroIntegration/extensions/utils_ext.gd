extends "res://singletons/utils.gd"

var Context = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/messages/outgoing/context.gd")
var ActionWindow = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/action_window.gd")
var NeuroActionHandler
var SelectAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/main_menu/select_thing.gd")
var InfoAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/main_menu/get_info.gd")

var regexr = RegEx.new()

enum MoveMode {
    KeepDistance,
    RunToClosestEnemy,
    MoveTo,
    #MoveCustom,
    Circle,
    Random,
    Idle
}
var move_mode = MoveMode.KeepDistance
var move_to_target: Vector2



func get_item_details(item) -> String:
    var info_text = ""
    info_text += "##" +item.get_name_text() + "\n"
    info_text += get_item_description(item) + "\n"
    return info_text

func get_item_description(item):
    var info_text = ""
    if item is WeaponData:
	    info_text= item.get_weapon_stats_text(0)
    else:
        info_text= item.get_effects_text(0)
    regexr.compile("\\[.*?\\]") # this is a to remove all color info and image paths from the text.  [Color] or res://****.png

    info_text = regexr.sub(info_text, "", true)

    info_text = info_text.replace("res://items/stats/", " ")
    info_text = info_text.replace(".png", ", ")

    return info_text
