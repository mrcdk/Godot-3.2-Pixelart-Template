extends CanvasLayer

func _ready() -> void:
	hide()

func show():
	$Control.show()
	
func hide():
	$Control.hide()
