#define LOG_TAG "node"

#include "node.h"
#include "v8.h"
#include "env.h"
#include "env-inl.h"
#include <utils/Log.h>
#include <cutils/log.h>
#include <stdio.h>
#include <stdlib.h>
#include "opus.h"
#include <string>


using namespace std;
using namespace v8;
using namespace android;
using namespace node;

static void Decode (const FunctionCallbackInfo<Value>& args) {
	EscapableHandleScope scope(args.GetIsolate());
	String::Utf8Value str(args[0]);
	long fsize;
	string pcm;
	FILE *fp;
	const int channels = 1;
	const int framesize = 320;
	const int samplerate = 16000;
	
	int error;
	OpusDecoder *pdecoder;
	pdecoder = opus_decoder_create(samplerate, channels, &error);

	short output[320*8];
	short *pOutput = output +framesize*2;
	long outLen = 0, outN = 0;
	fp = fopen("/data/siren_private/dump.opus","rb");
	if(fp==NULL){
		printf("open file error!!\n");
	}
	fseek(fp,0,SEEK_END);
	fsize = ftell(fp);
	rewind(fp);
	char *opus = (char*)malloc(sizeof(char)*fsize);
	if(opus == NULL){
		printf("malloc error!\n");
	}
	size_t result = fread(opus,1,fsize,fp);
	if(result != fsize){
		printf("reading error\n");
	}
	fclose(fp);
	const char *pbytes = opus;
	while(fsize>0){
		printf("reading start\n");
		int pkgsize = *pbytes;
		int decret = opus_decode(pdecoder,(const unsigned char*)pbytes+1,pkgsize,pOutput,framesize,0);
		outLen += decret;
		++outN;
		if(decret>0){
			pcm.append((char*)pOutput, sizeof(short)*decret);
			pbytes += pkgsize + 1;
			fsize -=pkgsize + 1;
		}
		else if(0 == decret)
			break;
		else{
			break;
		}
	}
		printf("reading stop\n");
	opus_decoder_destroy(pdecoder);
	free(opus);
	FILE *fpout;
	fpout = fopen("/data/siren_private/dump.pcm","wb");
	if(fpout==NULL){
		printf("open outfile error!!\n");
	}
	const char *oc = pcm.c_str();
	size_t length = pcm.length(); 
	size_t a = fwrite(oc,length,1,fpout);
	printf("a===%d\n",a);
	fclose(fpout);
	//printf("hello world!!!\n");
	
}


void init_decode(Local<Object> target, Local<Value> unused, Local<Context> context) {
	Environment* env = Environment::GetCurrent(context);
	env->SetMethod(target, "Decode", Decode);
}

NODE_MODULE_CONTEXT_AWARE_BUILTIN(Opus_Decode, init_decode)
