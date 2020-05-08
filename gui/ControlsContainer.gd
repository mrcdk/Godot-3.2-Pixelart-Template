extends PanelContainer

onready var ControlsTree = find_node("ControlsTree")

func _ready() -> void:
	var root = ControlsTree.create_item()
	ControlsTree.hide_root = true
	ControlsTree.set_column_expand(1, false)
	ControlsTree.set_column_min_width(1, 16)
	fill_tree()
	
func fill_tree() -> void:
	var root = ControlsTree.get_root()
	for action in InputMap.get_actions():
		#if action.begins_with("ui_"): continue
		var action_item = ControlsTree.create_item(root)
		action_item.set_text(0, action)
		for action_input in InputMap.get_action_list(action):
			var input_item = ControlsTree.create_item(action_item)
			input_item.set_text(0, action_input.as_text())
