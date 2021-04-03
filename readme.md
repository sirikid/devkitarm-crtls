# Building

Run commands below.

```
autoreconf -fiv
./configure --host=arm-none-eabi CFLAGS=-specs=nosys.specs
make
```
