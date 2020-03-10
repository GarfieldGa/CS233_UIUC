#include <cstdio>
using std::printf;

int main() {
  for (int i = 0; i < 32; i++) {
    printf("    dffe FlipFlop%d(q[%d], d[%d], clk, enable, reset);\n", i, i, i);
  }
}
