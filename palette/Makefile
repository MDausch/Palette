include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Palette
Palette_FILES = mdpaletteRootListController.m
Palette_INSTALL_PATH = /Library/PreferenceBundles
Palette_FRAMEWORKS = UIKit
Palette_PRIVATE_FRAMEWORKS = Preferences
Palette_LIBRARIES = colorpicker


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Palette.plist$(ECHO_END)
