LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc

ADDON_SRC_FILES := addon/rk_log.cc \
			addon/Opus_Decode.cc

NODE_SRC_FILES := 	src/debug-agent.cc \
					src/async-wrap.cc \
					src/env.cc \
					src/fs_event_wrap.cc \
					src/cares_wrap.cc \
					src/handle_wrap.cc \
					src/js_stream.cc \
					src/node.cc \
					src/node_buffer.cc \
					src/node_constants.cc \
					src/node_contextify.cc \
					src/node_file.cc \
					src/node_http_parser.cc \
					src/node_javascript.cc \
					src/node_main.cc \
					src/node_os.cc \
					src/node_util.cc \
					src/node_v8.cc \
					src/node_stat_watcher.cc \
					src/node_watchdog.cc \
					src/node_zlib.cc \
					src/node_i18n.cc \
					src/pipe_wrap.cc \
					src/signal_wrap.cc \
					src/spawn_sync.cc \
					src/string_bytes.cc \
					src/stream_base.cc \
					src/stream_wrap.cc \
					src/tcp_wrap.cc \
					src/timer_wrap.cc \
					src/tty_wrap.cc \
					src/process_wrap.cc \
					src/udp_wrap.cc \
					src/uv.cc \
					src/util.cc \
					src/string_search.cc \
					src/node_crypto.cc \
					src/node_crypto_bio.cc \
					src/node_crypto_clienthello.cc \
					src/tls_wrap.cc 


NODE_RELEASE_MODE := release
LOCAL_SRC_FILES := $(ADDON_SRC_FILES) $(NODE_SRC_FILES)
LOCAL_SHARED_LIBRARIES := libutils libcutils libbinder libeasyr2 libstlport libz libhardware libandroid_runtime libnativehelper libdl liblog libm \
	libztcodec2
	

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := node4r2
LOCAL_MODULE_CLASS := EXECUTABLES
GENERATED_SOURCE := $(call local-intermediates-dir)
$(info ---> ../../$(GENERATED_SOURCE))
LOCAL_PRELINK_MODULE := false
## by raymond yeung
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../easyr2/include/
## end of raymond yeung snippet

LOCAL_C_INCLUDES += bionic 
LOCAL_C_INCLUDES += prebuilts/ndk/10/sources/cxx-stl/llvm-libc++/libcxx/include

LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/ \
					$(LOCAL_PATH)/tools/msvs/genfiles \
					$(LOCAL_PATH)/deps/src/uv/src/ares \
				    ../../$(GENERATED_SOURCE)	\
					$(LOCAL_PATH)/deps/src/v8 \
					$(LOCAL_PATH)/deps/src/cares/include \
					$(LOCAL_PATH)/deps/src/v8/include \
					$(LOCAL_PATH)/deps/src/openssl/openssl/include \
					$(LOCAL_PATH)/deps/src/zlib \
					$(LOCAL_PATH)/deps/src/http_parser \
					$(LOCAL_PATH)/deps/src/uv/include \
					$(LOCAL_PATH)/addon


include $(LOCAL_PATH)/js_build.mk

LOCAL_CFLAGS += -D_GLIBCXX_USE_C99_MATH -DNODE_ARCH=\"arm\" -DNODE_PLATFORM=\"android\" -DNODE_WANT_INTERNALS=1 -DV8_DEPRECATION_WARNINGS=1 -DHAVE_OPENSSL=1 -D__POSIX__ -DHTTP_PARSER_STRICT=0 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

ifeq ($(NODE_RELEASE_MODE),debug)
LOCAL_CFLAGS += -DDEBUG -D_DEBUG
endif

LOCAL_CFLAGS += -Wall -Wextra -Wno-unused-parameter -fno-rtti -fno-exceptions -std=gnu++0x

ifeq ($(NODE_RELEASE_MODE),debug)
LOCAL_CFLAGS += -g -O0
else 
LOCAL_CFLAGS += -O3 -ffunction-sections -fdata-sections -fno-omit-frame-pointer
endif

#LOCAL_ARM_NEON := true                      
LIBS := 	$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libcares.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libv8_libplatform.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libopenssl.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libzlib.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libhttp_parser.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libuv.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libv8_base.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libv8_libbase.a \
			$(LOCAL_PATH)/deps/$(NODE_RELEASE_MODE)/libv8_snapshot.a \
			prebuilts/ndk/10/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_static.a
			
#EXTRA_CFLAGS += "-march=armv7-a -mfloat-abi=softfp -mfpu=neon"                                           
#EXTRA_LDFLAGS +="-Wl,--fix-cortex-a8 "

LOCAL_LDFLAGS+= "-Wl,--start-group" $(LIBS) "-Wl,--end-group"                                          
#ABI="armeabi-v7a"   


#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_EXECUTABLE)
