extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"

var detection_range_node: Area2D
var detection_range_shape: CollisionShape2D

var _current_target := []
var _targets_in_range := []

func _ready():
	yield (get_tree().create_timer(0.2), "timeout")
	detection_range_node = get_parent().get_node("player_add_in/detection_range")
	detection_range_shape = detection_range_node.get_node("detection_shape")
	detection_range_node.connect("body_entered", self, "_on_Range_body_entered")
	detection_range_node.connect("body_exited", self, "_on_Range_body_exited")

var move_until_time = 0
var move_until_random_target_pos: Vector2

var current_angle = 0
var other_current_angle = 0

var current_move_target: Vector2
var current_actual_target: Vector2

var last_move_vector: Vector2

func get_movement():
	match Utils.move_mode:
		Utils.MoveMode.RunToClosestEnemy:
			var unit = Utils.get_nearest(_targets_in_range, global_position, 0)
			
			if unit.size() > 0:
				return (unit[0].global_position - global_position).normalized()
			return do_random_movement()
		Utils.MoveMode.KeepDistance:
			var unit = Utils.get_nearest(_targets_in_range, global_position, 0)
			var ranmdom_move = do_random_movement()
			var new_vec = Vector2()
			if unit.size() > 0 and unit[1] < 200:
				var new_direction = (global_position - unit[0].global_position).normalized()
				var min_pos = ZoneService.current_zone_min_position
				var min_vec = global_position - min_pos
				var max_pos = ZoneService.current_zone_max_position
				var max_vec = max_pos - global_position
				print(min_vec, " ", max_vec)
				if (min_vec.x > 200 and min_vec.y > 200 and max_vec.x > 200 and max_vec.y > 200 and move_until_time <= 0):
					new_vec = new_direction
				else:
					if move_until_time == 0:
						move_until_time = 50
						move_until_random_target_pos = ZoneService.get_rand_pos_in_area_around_center(700)
						current_move_target = move_until_random_target_pos
						new_vec = new_direction
					else:
						move_until_time -= 1
						new_vec = ((move_until_random_target_pos - (global_position + (new_direction * unit[1])))).normalized()
			else:
				new_vec = ranmdom_move
			if move_until_time != 0:
				move_until_time -= 1
				new_vec = ((move_until_random_target_pos - global_position)).normalized()
			last_move_vector = lerp(last_move_vector, new_vec, 0.1)
			return last_move_vector
		Utils.MoveMode.MoveTo:
			if Utils.move_to_target.distance_to(global_position) < 10:
				Context.send("Reach goal at position %s, Setting move_mode to idle at location" % [Utils.move_to_target])
				Utils.move_mode = Utils.MoveMode.Idle
			return (Utils.move_to_target - global_position).normalized()
		Utils.MoveMode.Circle:
			current_angle = current_angle + 0.05
			var current_vec = Vector2(cos(current_angle), sin(current_angle))
			return current_vec.normalized()
		Utils.MoveMode.Random:
			return do_random_movement()
		Utils.MoveMode.Idle:
			return Vector2()
	return do_random_movement()

func do_random_movement():
	if current_move_target.length() == 0 or current_move_target.distance_to(global_position) < 300:
		current_move_target = ZoneService.get_rand_pos(200)
	var unit = Utils.get_nearest(_targets_in_range, global_position, 0)
	if unit.size() > 0 and unit[1] < 200:
		var new_direction = (unit[0].global_position - global_position) * (unit[1] * 0.7)
		current_actual_target = lerp(current_actual_target, (current_move_target - (global_position + new_direction).limit_length(1)), 0.01)
	else:
		current_actual_target = lerp(current_actual_target, (current_move_target - (global_position)), 0.03)
	return (current_actual_target).normalized()

func _on_Range_body_entered(body: Node) -> void:
	_targets_in_range.push_back(body)
	var _error = body.connect("died", self, "on_target_died")


func _on_Range_body_exited(body: Node) -> void:
	_targets_in_range.erase(body)
	if _current_target.size() > 0 and body == _current_target[0]:
		_current_target.clear()
	body.disconnect("died", self, "on_target_died")


func on_target_died(target: Node, _args: Entity.DieArgs) -> void:
	_targets_in_range.erase(target)
	if _current_target.size() > 0 and target == _current_target[0]:
		_current_target.clear()
