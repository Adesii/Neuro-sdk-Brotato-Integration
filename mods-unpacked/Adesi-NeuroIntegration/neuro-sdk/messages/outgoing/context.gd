class_name Context
extends "res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/messages/api/outgoing_message.gd"

var _message: String
var _silent: bool

func _init(message: String, silent: bool = false):
	_message = message
	_silent = silent

func _get_command() -> String:
	return "context"

func _get_data() -> Dictionary:
	return {
		"message": _message,
		"silent": _silent
	}

static func send(message: String, silent: bool = false):
	ModLoader.get_tree().root.get_node("/root/ModLoader/Adesi-NeuroIntegration/WebsocketNode").send(load("res://mods-unpacked/Adesi-NeuroIntegration/neuro-sdk/messages/outgoing/context.gd").new(message, silent))