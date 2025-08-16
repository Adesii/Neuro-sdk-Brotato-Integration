extends "res://singletons/utils.gd"

var Context = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/messages/outgoing/context.gd")
var ActionWindow = preload("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/actions/action_window.gd")
var NeuroActionHandler
var SelectAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/select_thing.gd")
var InfoAction = preload("res://mods-unpacked/Adesi-NeuroIntegration/broactions/get_info.gd")

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