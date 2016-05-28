#include <uv.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int main() {
	printf ("start uv test\n");
	uv_loop_t loop;
	uv_loop_init (&loop);
	printf ("uv run\n");
	uv_run(&loop, UV_RUN_DEFAULT);
}
