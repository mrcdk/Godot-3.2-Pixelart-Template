extends Control

onready var Model = find_node("Model")

func _process(delta):
	var focus_owner = get_focus_owner()
	if not focus_owner or focus_owner.focus_mode == Control.FOCUS_CLICK:
		visible = false
		return
	
	var scroll_container = _find_scroll_container(focus_owner)
	
	if scroll_container:
		focus_owner = scroll_container
	
	var target = focus_owner.rect_global_position
	target.y += focus_owner.rect_size.y / 2
	
	if target.x < 10:
		Model.position.x = -2
	else:
		Model.position.x = -6
	
	if not visible:
		rect_global_position = target
		visible = true
		return
		
	var speed = 600
	if rect_global_position.distance_to(target) > 80:
		speed = 2000
	rect_global_position = rect_global_position.move_toward(target, speed * delta)
	
func _find_scroll_container(node:Control):
	if node is ScrollContainer:
		return node
	else:
		var parent = node.get_parent()
		if not parent or not parent is Control:
			return null
		return _find_scroll_container(node.get_parent())
