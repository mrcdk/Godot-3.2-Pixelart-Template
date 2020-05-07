extends PanelContainer

export (StyleBox) var focused_style = null
export (StyleBox) var unfocused_style = null

onready var EnabledCheck = find_node("EnabledCheck")
onready var FlagTexture = find_node("FlagTexture")
onready var LanguageLabel = find_node("LanguageLabel")

var language = "en"

func _ready():
	set("custom_styles/panel", unfocused_style)
	FlagTexture.texture = load("res://assets/gui/flags/%s.png" % language)
	LanguageLabel.text = "settings_language_%s" % language


func _on_LanguageEntry_gui_input(event: InputEvent) -> void:
	var change_language = false
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.pressed and event.button_index == BUTTON_LEFT:
			change_language = true
			
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select"):
		change_language = true
			
	if change_language:
		Settings.settings.language = language


func _on_LanguageEntry_focus_entered() -> void:
	set("custom_styles/panel", focused_style)

func _on_LanguageEntry_focus_exited() -> void:
	set("custom_styles/panel", unfocused_style)

func _on_LanguageEntry_visibility_changed() -> void:
	if visible:
		Settings.settings.language = language
