extends "res://entities/units/player/player.gd"

var detection_range_node = preload("res://mods-unpacked/Adesi-NeuroIntegration/scenes/player_add_in.tscn")

func _ready():
    ._ready()
    var instance_node = detection_range_node.instance()
    add_child(instance_node)
