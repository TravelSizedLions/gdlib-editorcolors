@tool
class_name EditorColorUtilTests extends TDTest

var settings = {}

func build(for_setting: String): 
  var MockEditorSettings = mock(EditorSettingsWrapper)
  MockEditorSettings.get_setting.mock(func(): return settings[for_setting])
  var editor_settings = MockEditorSettings.new()
  var EditorUIMock = mock(EditorUI)
  EditorUIMock.settings = editor_settings

  var util = EditorColorUtils.new()
  util.__editor = EditorUIMock.new()
  return util

func test_drive():
  before_each(func():
    settings = {
      primary=Color(0.5, 0.5, 0.5),
      secondary=Color(0.3, 0.3, 0.3)
    }
  )

  group('primary and secondary color accessors', func():
    test('gets the most up-to-date the primary color', func():
      var util = build('primary')
      assert_equal(util.primary_color, settings.primary)
      settings.primary = Color.BEIGE
      assert_equal(util.primary_color, settings.primary)
    )

    test('gets the most up-to-date the secondary color', func():
      var util = build('secondary')
      assert_equal(util.secondary_color, settings.secondary)
      settings.secondary = Color.BEIGE
      assert_equal(util.secondary_color, settings.secondary)
    )
  )

  group('color filtering', func():
    test('can lighten the primary color', func():
      var util = build('primary')
      var prim = util.primary_color
      var light = util.primary_color_lightened(1)
      assert_true(light.v > prim.v)

      var lighter = util.primary_color_lightened(3)
      assert_true(lighter.v > light.v)
    )

    test('can darken the primary color', func():
      var util = build('primary')
      var prim = util.primary_color
      var dark = util.primary_color_darkened(1)
      assert_true(dark.v < prim.v)

      var darker = util.primary_color_darkened(2)
      assert_true(darker.v < dark.v)
    )

    test('can lighten the secondary color', func():
      var util = build('secondary')
      var sec = util.secondary_color
      var light = util.secondary_color_lightened(1)
      assert_true(light.v > sec.v)

      var lighter = util.secondary_color_lightened(3)
      assert_true(lighter.v > light.v)
    )

    test('can darken the secondary color', func():
      var util = build('secondary')
      var sec = util.secondary_color
      var dark = util.secondary_color_darkened(1)
      assert_true(dark.v < sec.v)

      var darker = util.secondary_color_darkened(2)
      assert_true(darker.v < sec.v)
    )

    test('can lighten the primary color all the way up to white', func():
      var util = build('primary')
      assert_equal(util.primary_color_lightened(999), Color.WHITE)  
    )

    test('can lighten the secondary color all the way up to white', func():
      var util = build('secondary')
      assert_equal(util.secondary_color_lightened(999), Color.WHITE)  
    )

    test('can darken the primary color all the way down to black', func():
      var util = build('primary')
      assert_equal(util.primary_color_darkened(999), Color.BLACK)  
    )

    test('can darken the secondary color all the way down to black', func():
      var util = build('secondary')
      assert_equal(util.secondary_color_darkened(999), Color.BLACK)  
    )
  )
