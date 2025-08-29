extends "res://ui/menus/shop/shop.gd"

# TODO: needed actions: reroll_shop, lock_item, buy_item, get_info_for_item, get_stats, combine_weapon, sell_weapon,steal_weapon,go_next_wave
# im probably still missing some actions
var current_shop_items = []

var reroll_shop = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/reroll_shop.gd")
var lock_item = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/lock_item.gd")
var buy_item = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/buy_item.gd")
var get_info_for_item = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/get_info_for_item.gd")
var get_stats = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/get_stats.gd")
var combine_weapon = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/combine_weapon.gd")
var sell_weapon = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/sell_weapon.gd")
var steal_weapon = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/steal_weapon.gd")
var go_next_wave = load("res://mods-unpacked/Adesi-NeuroIntegration/broactions/shop/go_next_wave.gd")

func _ready():
    ._ready()

    print("Entered Shop")


func update_shop_and_re_register():
    current_shop_items = _get_shop_items_container(0)._shop_items
    var action_window = Utils.ActionWindow.new(self)
    for action in get_all_updated_actions(action_window):
        action_window.add_action(action)
    action_window.set_context("You are now in the Shop, it is wave %s and you have %s money to spend. When you are ready and think you can't improve your build anymore, use the go_next_wave action to start the next wave and leave the shop, any locked items will remain in the next shop" % [str(RunData.current_wave),str(RunData.get_player_gold(0))])
    action_window.register()


func get_all_updated_actions(window):
    return []
