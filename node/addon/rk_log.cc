#define LOG_TAG "node"

#include "node.h"
#include "v8.h"
#include "env.h"
#include "env-inl.h"
#include <utils/Log.h>
#include <cutils/log.h>


using namespace v8;
using namespace android;
using namespace node;

static void Logi (const FunctionCallbackInfo<Value>& args) {
	EscapableHandleScope scope(args.GetIsolate());
	String::Utf8Value str(args[0]);
	
	ALOGI ("%s", *str);
}

static void Logw (const FunctionCallbackInfo<Value>& args) {
	EscapableHandleScope scope(args.GetIsolate());
	String::Utf8Value str(args[0]);

	ALOGW ("%s", *str);
}

static void Loge (const FunctionCallbackInfo<Value>& args) {
	EscapableHandleScope scope(args.GetIsolate());
	String::Utf8Value str(args[0]);

	ALOGE ("%s", *str);
}

void init_logcat(Local<Object> target, Local<Value> unused, Local<Context> context) {
	Environment* env = Environment::GetCurrent(context);
	env->SetMethod(target, "i", Logi);
	env->SetMethod(target, "w", Logw);
	env->SetMethod(target, "e", Loge);
}

NODE_MODULE_CONTEXT_AWARE_BUILTIN(log, init_logcat)
