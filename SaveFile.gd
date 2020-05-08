extends Resource
class_name SaveFile

export (Vector2) var image_size = Vector2.ZERO
export (int) var image_format = 0
export (int) var uncompressed_size = 0
export (PoolByteArray) var compressed_image_buffer = PoolByteArray()

export (String) var title = ""
export (int) var timestamp = 0

export (PoolByteArray) var data = PoolByteArray()
export (int) var data_size = 0

var _data = {
	"player_position": Vector2(100, 20),
	"health": 100,
	"enemies_left": 50,
	"test": "testing a string",
}

var image_texture = ImageTexture.new()

func get_texture():
	if compressed_image_buffer.empty(): return image_texture
	
	var img = Image.new()
	var buffer = compressed_image_buffer.decompress(uncompressed_size, File.COMPRESSION_DEFLATE)
	img.create_from_data(image_size.x, image_size.y, false, image_format, buffer)
	
	image_texture.create_from_image(img)
	
	return image_texture

func save_file(image:Image, title):
	if image:
		
		image_size = image.get_size()
		image_format = image.get_format()
		
		var buffer = image.get_data()
		uncompressed_size = buffer.size()
		compressed_image_buffer = buffer.compress(File.COMPRESSION_DEFLATE)
		
		print(image_size, " ", uncompressed_size)
		
	self.title = title
	timestamp = OS.get_unix_time()
	var bytes = var2bytes(_data)
	data_size = bytes.size()
	data = bytes.compress(File.COMPRESSION_DEFLATE)
	
	ResourceSaver.save("user://tmp.res", self)
	
func load_file():
	pass
