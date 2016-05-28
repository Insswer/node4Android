generated_sources := $(local-intermediates-dir)


JS_LIB_DIR := $(call my-dir)
JS_ADDON_SRC := $(JS_LIB_DIR)/lib/log.js

JS_SRC := $(JS_LIB_DIR)/src/node.js \
		$(JS_LIB_DIR)/lib/_debug_agent.js \
		$(JS_LIB_DIR)/lib/_debugger.js \
		$(JS_LIB_DIR)/lib/assert.js \
		$(JS_LIB_DIR)/lib/buffer.js \
		$(JS_LIB_DIR)/lib/child_process.js \
		$(JS_LIB_DIR)/lib/console.js \
		$(JS_LIB_DIR)/lib/constants.js \
		$(JS_LIB_DIR)/lib/crypto.js \
		$(JS_LIB_DIR)/lib/cluster.js \
		$(JS_LIB_DIR)/lib/dgram.js \
		$(JS_LIB_DIR)/lib/dns.js \
		$(JS_LIB_DIR)/lib/domain.js \
		$(JS_LIB_DIR)/lib/events.js \
		$(JS_LIB_DIR)/lib/fs.js \
		$(JS_LIB_DIR)/lib/http.js	 \
		$(JS_LIB_DIR)/lib/_http_agent.js \
		$(JS_LIB_DIR)/lib/_http_client.js \
		$(JS_LIB_DIR)/lib/_http_common.js \
		$(JS_LIB_DIR)/lib/_http_incoming.js  \
		$(JS_LIB_DIR)/lib/_http_outgoing.js \
		$(JS_LIB_DIR)/lib/_http_server.js \
		$(JS_LIB_DIR)/lib/https.js \
		$(JS_LIB_DIR)/lib/_linklist.js \
		$(JS_LIB_DIR)/lib/module.js  \
		$(JS_LIB_DIR)/lib/net.js \
		$(JS_LIB_DIR)/lib/os.js \
		$(JS_LIB_DIR)/lib/path.js \
		$(JS_LIB_DIR)/lib/process.js \
		$(JS_LIB_DIR)/lib/punycode.js \
		$(JS_LIB_DIR)/lib/querystring.js \
		$(JS_LIB_DIR)/lib/readline.js \
		$(JS_LIB_DIR)/lib/repl.js \
		$(JS_LIB_DIR)/lib/stream.js  \
		$(JS_LIB_DIR)/lib/_stream_readable.js \
		$(JS_LIB_DIR)/lib/_stream_writable.js \
		$(JS_LIB_DIR)/lib/_stream_duplex.js \
		$(JS_LIB_DIR)/lib/_stream_transform.js \
		$(JS_LIB_DIR)/lib/_stream_passthrough.js \
		$(JS_LIB_DIR)/lib/_stream_wrap.js \
		$(JS_LIB_DIR)/lib/string_decoder.js \
		$(JS_LIB_DIR)/lib/sys.js \
		$(JS_LIB_DIR)/lib/timers.js \
		$(JS_LIB_DIR)/lib/tls.js \
		$(JS_LIB_DIR)/lib/_tls_common.js \
		$(JS_LIB_DIR)/lib/_tls_legacy.js \
		$(JS_LIB_DIR)/lib/_tls_wrap.js \
		$(JS_LIB_DIR)/lib/tty.js \
		$(JS_LIB_DIR)/lib/url.js \
		$(JS_LIB_DIR)/lib/util.js \
		$(JS_LIB_DIR)/lib/v8.js \
		$(JS_LIB_DIR)/lib/vm.js \
		$(JS_LIB_DIR)/lib/zlib.js \
		$(JS_LIB_DIR)/lib/internal/child_process.js \
		$(JS_LIB_DIR)/lib/internal/cluster.js \
		$(JS_LIB_DIR)/lib/internal/freelist.js \
		$(JS_LIB_DIR)/lib/internal/linkedlist.js \
		$(JS_LIB_DIR)/lib/internal/module.js \
		$(JS_LIB_DIR)/lib/internal/readline.js \
		$(JS_LIB_DIR)/lib/internal/repl.js \
		$(JS_LIB_DIR)/lib/internal/socket_list.js \
		$(JS_LIB_DIR)/lib/internal/util.js \
		$(JS_LIB_DIR)/lib/internal/streams/lazy_transform.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/splaytree.js\
		$(JS_LIB_DIR)/deps/src/v8/tools/codemap.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/consarray.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/csvparser.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/profile.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/profile_view.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/logreader.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/tickprocessor.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/SourceMap.js\
		$(JS_LIB_DIR)/deps/src/v8/tools/tickprocessor-driver.js \
		$(JS_LIB_DIR)/deps/src/v8/tools/mac-nm

NODE_EXTRA := $(JS_LIB_DIR)/config.gypi \
				$(JS_LIB_DIR)/src/notrace_macros.py \
				$(JS_LIB_DIR)/src/nolttng_macros.py \
				$(JS_LIB_DIR)/src/perfctr_macros.py

GEN :=  $(generated_sources)/node_natives.h
JS2C_PY := $(JS_LIB_DIR)/tools/js2c.py
$(GEN): SCRIPT := $(JS_LIB_DIR)/tools/js2c.py
$(GEN):	$(JS_SRC) $(JS2C_PY)
	@echo "Generating node_natives"
	@echo "**************************************"
	python $(SCRIPT) $(GEN) $(JS_SRC) $(NODE_EXTRA)
	@echo "**************************************"	

LOCAL_GENERATED_SOURCES += $(GEN)

