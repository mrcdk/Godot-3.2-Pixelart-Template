extends VBoxContainer

onready var Languages = find_node("Languages")

var language_entry_scene = preload("res://gui/LanguageEntry.tscn")
var index = 0

func _ready() -> void:
	var languages = ProjectSettings.get_setting("locale/locale_order")
	var loaded = TranslationServer.get_loaded_locales()
	for language in languages:
		if not language in loaded:
			continue
		var entry = language_entry_scene.instance()
		entry.language = language
		entry.hide()
		Languages.add_child(entry)
		
	Languages.get_child(index).show()
	
func _change():
	for i in Languages.get_child_count():
		if i == index:
			Languages.get_child(i).show()
		else:
			Languages.get_child(i).hide()

func _on_PrevButton_pressed() -> void:
	index = wrapi(index - 1, 0, Languages.get_child_count())
	_change()
	
func _on_NextButton_pressed() -> void:
	index = wrapi(index + 1, 0, Languages.get_child_count())
	_change()
