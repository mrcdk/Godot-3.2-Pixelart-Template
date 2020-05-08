extends CanvasLayer

signal scene_loaded(scene)
signal change_finished()

onready var BlackRect = find_node("BlackRect")
onready var FadeAnimations = find_node("FadeAnimations")
onready var LoadingLabel = find_node("LoadingLabel")
onready var LoadDelayTimer = find_node("LoadDelayTimer")
onready var LoadingProgress = find_node("LoadingProgress")
onready var LoadingContainer = find_node("LoadingContainer")
onready var LoadingAnimations = find_node("LoadingAnimations")

var load_thread:Thread = Thread.new()

var hide_loading = false

func _ready() -> void:
	LoadingContainer.modulate.a = 0.0
	BlackRect.color.a = 0.0

func change_scene(scene_path:String, skip_fade_to_black:bool = false, skip_fade_from_black:bool = false):
	_update_loading_text()
	
	if not skip_fade_to_black:
		fade_to_black()
		yield(FadeAnimations, "animation_finished")
	else:
		BlackRect.color.a = 1.0
	
	hide_loading = false
	var start_loading = true
	if load_thread.is_active():
		print("Oh no, loading thread active!")
		start_loading = false
	
	if start_loading:
		LoadDelayTimer.start()
		
		load_thread.start(self, "_load_scene", scene_path)
		var loaded_scene = yield(self, "scene_loaded")
		load_thread.wait_to_finish()
		
		LoadDelayTimer.stop()
		
		_update_progress(1, 1)
		# TODO fix this
		if loaded_scene:
			get_tree().change_scene_to(loaded_scene)
		else:
			print("ERROR! SCENE NOT LOADED")
		
	if hide_loading:
		LoadingAnimations.play("hide")
		yield(LoadingAnimations, "animation_finished")
		
	if not skip_fade_from_black:
		fade_from_black()
		yield(FadeAnimations, "animation_finished")
	else:
		BlackRect.color.a = 0.0
	
	emit_signal("change_finished")

func fade_to_black():
	FadeAnimations.play("fade_to_black")
	
func fade_from_black():
	FadeAnimations.play("fade_from_black")
	
func _update_progress(current:int, max_items:int):
	LoadingProgress.max_value = max_items
	LoadingProgress.value = current
	
func _update_loading_text():
	var translated_text = tr("common_loading_scene")
	var font = LoadingLabel.get_font("normal_font")
	var size = font.get_string_size(translated_text)
	LoadingLabel.rect_min_size = size
	LoadingLabel.bbcode_text = "[wave amp=16 freq=2]%s[/wave]" % translated_text
	
func _load_scene(scene_path):
	var loader = ResourceLoader.load_interactive(scene_path)
	while true:
		var result = loader.poll()
		match result:
			ERR_FILE_EOF:
				break
			OK:
				call_deferred("_update_progress", loader.get_stage(), loader.get_stage_count())
				#yield(get_tree().create_timer(0.1), "timeout")
			_:
				call_deferred("emit_signal", "scene_loaded", null)
		
	call_deferred("emit_signal", "scene_loaded", loader.get_resource())


func _on_LoadDelayTimer_timeout() -> void:
	LoadingAnimations.play("show")
	hide_loading = true
