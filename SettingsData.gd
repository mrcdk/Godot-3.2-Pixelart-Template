extends Resource
class_name SettingsData

export (Dictionary) var audio_volumes = {
	"Master": 0.8,
	"Music": 0.8,
	"SFX": 0.8,
} setget _set_audio_volumes
export (bool) var fullscreen_enabled = false setget _set_fullscreen_enabled
export (String) var language = "en" setget _set_language

func apply():
	self.language = language
	self.fullscreen_enabled = fullscreen_enabled
	self.audio_volumes = audio_volumes

func set_volume(bus:String, volume:float):
	audio_volumes[bus] = volume
	var bus_id = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_id, linear2db(volume))

func _set_audio_volumes(new_volumes:Dictionary):
	audio_volumes = new_volumes
	for bus in audio_volumes:
		set_volume(bus, audio_volumes.get(bus, 0.8))

func _set_fullscreen_enabled(new_value:bool):
	fullscreen_enabled = new_value
	if fullscreen_enabled:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
		
func _set_language(new_value:String):
	language = new_value
	TranslationServer.set_locale(language)
