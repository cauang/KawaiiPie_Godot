extends CanvasLayer

signal countdown_finished

@onready var countdown_label = $CountdownLabel
var count = 3

func _ready():
	start_countdown()

func start_countdown():
	countdown_label.text = str(count)
	await get_tree().create_timer(1.0).timeout
	
	count -= 1
	if count >= 0:
		start_countdown()
	else:
		countdown_label.text = "GO!"
		await get_tree().create_timer(0.5).timeout
		emit_signal("countdown_finished")
		queue_free()
