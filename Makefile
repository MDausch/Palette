ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Palette
Palette_FILES = Palette.xm
Palette_LIBRARIES = colorpicker


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += palette
include $(THEOS_MAKE_PATH)/aggregate.mk
