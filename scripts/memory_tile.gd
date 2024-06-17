extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var item_name: String
var can_select_me: bool = true

func _ready():
	SignalManager.selection_enabled.connect(on_selection_enabled)
	SignalManager.selection_disabled.connect(on_selection_disabled)

func get_item_name() -> String:
	return item_name

func reveal_image(reveal: bool) -> void:
	frame_image.visible = reveal
	item_image.visible = reveal

func setup(item_info: Dictionary, new_frame_image: CompressedTexture2D) -> void:
	frame_image.texture = new_frame_image
	item_image.texture = item_info.item_texture
	item_name = item_info.item_name
	reveal_image(false)

func kill_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", deg_to_rad(720), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2(0, 0), 0)

func on_selection_enabled() -> void:
	can_select_me = true

func on_selection_disabled() -> void:
	can_select_me = false

func _on_pressed():
	if can_select_me:
		SignalManager.tile_selected.emit(self)
