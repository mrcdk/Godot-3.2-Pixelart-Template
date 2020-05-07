tool
extends EditorScript

func _run() -> void:
	var image:Image = load("res://assets/gui/flags/all_flags.png")
	image.convert(Image.FORMAT_RGBA8)
	var columns = int(image.get_width() / 24)
	var rows = int(image.get_height() / 24)
	var id = 0
	for row in rows:
		for column in columns:
			var name = "unknown_%s" % str(id).pad_zeros(3)
			var src_rect = Rect2(column * 24, row * 24 + 1, 24, 22)

			var flag = Image.new()
			flag.create(24, 24, true, Image.FORMAT_RGBA8)
			flag.fill(Color.transparent)
			flag.blit_rect(image, src_rect, Vector2(0, 1))
			flag.save_png("res://assets/gui/flags/split/%s.png" % name)
			
			id += 1
