extends PanelContainer

onready var SaveTexture = find_node("SaveTexture")
onready var TitleLabel = find_node("TitleLabel")
onready var DateLabel = find_node("DateLabel")

func _ready() -> void:
	setup()
	
func setup():
	DateLabel.text = tr("saveload_entry_date").format({
		"hour": str(1).pad_zeros(2),
		"minute": str(35).pad_zeros(2),
		"second": str(58).pad_zeros(2),
		"day": str(12).pad_zeros(2),
		"month": str(5).pad_zeros(2),
		"year": 2020,
		"ampm": "AM",
	})
