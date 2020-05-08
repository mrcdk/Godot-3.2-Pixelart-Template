extends PanelContainer

onready var EnabledCheck = find_node("EnabledCheck")
onready var FlagTexture = find_node("FlagTexture")
onready var LanguageLabel = find_node("LanguageLabel")

var language = "en"

func _ready():
	FlagTexture.texture = load("res://assets/gui/flags/%s.png" % language)
	LanguageLabel.text = "settings_language_%s" % language

func _on_LanguageEntry_visibility_changed() -> void:
	if visible:
		Settings.settings.language = language
