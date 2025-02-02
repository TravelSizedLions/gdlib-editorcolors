@tool
class_name EditorColorUtils

static var __editor

static func _static_init() -> void:
  if not __editor:
    __editor = EditorUI.new()

var primary_color: Color:
  get: 
    if not __editor:
      return Color.WHITE
    return __editor.settings.get_setting('interface/theme/base_color')

func primary_color_darkened(degrees: int):
  var color = primary_color
  color.v *= 0.9**degrees
  color.v = clampf(color.v, 0, 1)
  return color

func primary_color_lightened(degrees: int):
  var color = primary_color
  color.v *= 1.1**degrees
  color.v = clampf(color.v, 0, 1)
  return color

var secondary_color: Color:
  get: return __editor.settings.get_setting('interface/theme/accent_color')
  
func add_color_change_observer(fn: Callable):
  __editor.settings.settings_changed.connect(fn)
