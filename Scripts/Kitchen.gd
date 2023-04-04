class_name Kitchen
extends Node2D

signal day_is_over

var purchased_upgrades : UpgradesReceipt = UpgradesReceipt.new()

# no upgrades
# good ingredients: ['Milk', 'Eggs', 'Butter', 'Sugar', 'Flour']
# bad ingredients: ['FishHead', 'Bottle', 'BlackBlock', 'OpenedCan', 'Burger']
var fridge_game : PackedScene = preload("res://Scenes/Microgames/FridgeMicrogame.tscn")
var batter_game : PackedScene = preload("res://Scenes/Microgames/PouringMicrogame.tscn")
var icing_game : PackedScene = preload("res://Scenes/Microgames/IcingMicrogame.tscn")
var sprinkle_game : PackedScene = preload("res://Scenes/Microgames/DecorationMicrogame.tscn")
var cooling_game : PackedScene = preload("res://Scenes/Microgames/CoolingMicrogame.tscn")

# has upgrades
var mixing_game : PackedScene = preload("res://Scenes/Microgames/StirMicrogame.tscn")
var cutting_game : PackedScene = preload("res://Scenes/Microgames/CutterMicrogame.tscn")
var oven_game : PackedScene = preload("res://Scenes/Microgames/OvenMicrogame.tscn")

var test : PackedScene = preload("res://Scenes/test.tscn")

func _ready():
	var seconds_remaining = ceil($round_timer.time_left)
	$info_ui/VBoxContainer/panel/padding/time_label.text = "Time Remaining: %s" % seconds_remaining

func _on_order_source_invoked():
	$order_tracker.current_order = $order_spawner.next_order

func _on_destination_highlight_invoked():
	$order_tracker.complete_order()

func _on_fridge_highlight_invoked():
#	var game = fridge_game.instantiate()
	
#	game.game_ended.connect(game_ended)
#
#	$microgames.add_child(game)
#	var good : Array[String] = ['Eggs', "Flour", 'Butter']
#	var bad : Array[String] = ['FishHead', 'Bottle']
#	game.start(good, bad)
##	game.set_upgraded(purchased_upgrades.tuneUpActivated)
	$order_tracker.next_step()

func _on_mixing_highlight_invoked():
#	var game = mixing_game.instantiate()
#	game.game_ended.connect(game_ended)
#	$microgames.add_child(game)
#	game.set_upgraded(purchased_upgrades.whiskActivated)
	$order_tracker.next_step()
#	var game = test.instantiate()
#	$microgames.add_child(game)

func _on_batter_highlight_invoked():
	var game = batter_game.instantiate()
	game.game_ended.connect(game_ended)
	$microgames.add_child(game)
#	$order_tracker.next_step()

func _on_cutting_highlight_invoked():
	$order_tracker.next_step()

func _on_icing_highlight_invoked():
	$order_tracker.next_step()

func _on_sprinkle_highlight_invoked():
	$order_tracker.next_step()

func _on_oven_highlight_invoked():
	$order_tracker.next_step()

func _on_cooling_highlight_invoked():
	$order_tracker.next_step()

func _on_order_changed(order):
	$info_ui/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/order_tracker_ui.order = order

func _on_progress_changed(progress):
	$info_ui/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/order_tracker_ui.progress = progress

func _on_round_timer_timeout():
	emit_signal("day_is_over", purchased_upgrades)

func _update_time_remaining_label():
	var seconds_remaining = ceil($round_timer.time_left)
	$info_ui/VBoxContainer/panel/padding/time_label.text = "Time Remaining: %s" % seconds_remaining

func game_ended(results):
	for node in $microgames.get_children():
		node.queue_free()

	$order_tracker.next_step
