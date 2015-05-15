include $(GNUSTEP_MAKEFILES)/common.make

PACKAGE_NAME=GNUProgrammer
VERSION=0.1

APP_NAME=GNUProgrammer

GNUProgrammer_OBJC_FILES = \
main.m \
programmer.m \
EncodingClasses/cppEncoding.m \
EncodingClasses/vbsEncoding.m \
EncodingClasses/pytwoEncoding.m \
EncodingClasses/pythreeEncoding.m \
EncodingClasses/luaEncoding.m \
EncodingClasses/cmdEncoding.m \
EncodingClasses/utils.m \
command.m 


GNUProgrammer_HEADERS = \
programmer.h \
EncodingClasses/vbsEncoding.h \
EncodingClasses/cppEncoding.h \
EncodingClasses/pythreeEncoding.h \
EncodingClasses/pytwoEncoding.h \
EncodingClasses/luaEncoding.h \
EncodingClasses/cmdEncoding.h \
EncodingClasses/utils.h \
command.h


GNUProgrammer_RESOURCE_FILES = \
gui.gorm

GNUProgrammer_MAIN_MODEL_FILE = \
gui.gorm

include $(GNUSTEP_MAKEFILES)/application.make
include $(GNUSTEP_MAKEFILES)/Master/nsis.make