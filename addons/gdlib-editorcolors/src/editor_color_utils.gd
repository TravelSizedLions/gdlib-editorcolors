@tool
class_name EditorColorUtils

var __editor = EditorUI.new()

var primary_color: Color:
  get: 
    if not __editor:
      return Color.WHITE
    return __editor.settings.get_setting('interface/theme/base_color')

var secondary_color: Color:
  get: 
    if not __editor:
      return Color.WHITE
    return __editor.settings.get_setting('interface/theme/accent_color')

func primary_color_darkened(degrees: int):
  var color = Color(primary_color)
  color.v *= 0.9**degrees
  color.v = clampf(color.v, 0, 1)
  return color

func primary_color_lightened(degrees: int):
  var color = Color(primary_color)
  var mult = 1.1**degrees
  var val = clampf(color.v*mult, 0, 1)
  color.v = val
  return color

func secondary_color_darkened(degrees: int):
  var color = Color(secondary_color)
  color.v *= 0.9**degrees
  color.v = clampf(color.v, 0, 1)
  return color

func secondary_color_lightened(degrees: int):
  var color = Color(secondary_color)
  var mult = 1.1**degrees
  var val = clampf(color.v*mult, 0, 1)
  color.v = val
  return color

func add_color_change_observer(fn: Callable):
  __editor.settings.settings_changed.connect(fn)
