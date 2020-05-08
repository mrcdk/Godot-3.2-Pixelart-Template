extends CanvasLayer

func _ready() -> void:
	if not OS.get_name() == "HTML5":
		queue_free()
	else:
		get_child(0).show()

func _on_OkayButton_pressed() -> void:
	Events.emit_signal("html5_click_grabber_clicked")
	queue_free()
