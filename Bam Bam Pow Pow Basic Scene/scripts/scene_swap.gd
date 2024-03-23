extends Node

var cur_scene = null # Save a variable that will hold the current scene's path

func _ready() -> void:
	# Save the path to the root node then set the current scene to the node just below the root
	var root = get_tree().root
	cur_scene = root.get_child(root.get_child_count() - 1)
	
func scene_swap(scene_path):
	call_deferred("_deferred_scene_swap", scene_path)

func _deferred_scene_swap(scene_path):
	
	# Add fade scene on top.
	var fade = load("res://Scenes/fade.tscn").instantiate()
	get_tree().root.add_child(fade)
	fade.fade_to_black()
	
	await fade.faded
	# Fade is complete.
	cur_scene.queue_free()
	var new_scene = load(scene_path)
	cur_scene = new_scene.instantiate()
	get_tree().root.add_child(cur_scene)
	get_tree().current_scene = cur_scene
	
	# Fade out then remove fade scene.
	fade.fade_to_norm()
	
	await fade.norm
	# still need to delete fade
	get_tree().root.remove_child(fade)
	fade.queue_free()
