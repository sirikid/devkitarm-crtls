prefix = /usr/arm-none-eabi
libdir = $(prefix)/lib

sources = $(wildcard *.S)
objects = $(patsubst %.S, %.arm.o, $(sources)) $(patsubst %.S, %.thumb.o, $(sources))

.PHONY: all clean install

all: $(objects)

clean:
	$(RM) $(objects)

install:
	install -D -t $(DESTDIR)$(libdir)/arm/v4t gp32_*.arm.o er_*.arm.o gba_*.arm.o ds_cart_*.arm.o ds_arm7_*.arm.o
	install -D -t $(DESTDIR)$(libdir)/arm/v5te ds_arm9_*.arm.o
	install -D -t $(DESTDIR)$(libdir)/thumb/v4t gp32_*.thumb.o er_*.thumb.o gba_*.thumb.o ds_cart_*.thumb.o ds_arm7_*.thumb.o
	install -D -t $(DESTDIR)$(libdir)/thumb/v5te ds_arm9_*.thumb.o

AS = arm-none-eabi-as

%.arm.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.thumb.o: %.s
	$(AS) $(ASFLAGS) -mthumb -o $@ $<

gp32_%:    ASFLAGS += -mcpu=arm920t
er_%:      ASFLAGS += -mcpu=arm7tdmi
gba_%:     ASFLAGS += -mcpu=arm7tdmi
ds_cart_%: ASFLAGS += -mcpu=arm7tdmi
ds_arm7_%: ASFLAGS += -mcpu=arm7tdmi
ds_arm9_%: ASFLAGS += -mcpu=arm946e-s
3dsx_%:    ASFLAGS += -mcpu=mpcore -mfloat-abi=hard

ds_arm7_vram_%: CPPFLAGS += -DVRAM
