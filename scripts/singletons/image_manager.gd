extends Node

const FRAME_IMAGES: Array = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
	preload("res://assets/frames/green_frame.png")
]

var images: Array = []

func _ready():
	load_images()

func add_file_to_list(file_name: String, path: String) -> void:
	var full_path = path + "/" + file_name
	
	var image_info = {
		"item_name": file_name.rstrip(".png"),
		"item_texture": load(full_path)
	}
	
	images.append(image_info)

func load_images():
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if !dir:
		print("ERROR: ", path)
		return
	
	var file_names = dir.get_files()
	
	for file_name in file_names:
		if ".import" not in file_name:
			add_file_to_list(file_name, path)

func get_random_image() -> Dictionary:
	return images.pick_random()

func get_image(index: int) -> Dictionary:
	return images[index]

func get_random_frame_image() -> CompressedTexture2D:
	return FRAME_IMAGES.pick_random()

func shuffle_images() -> void:
	images.shuffle()
