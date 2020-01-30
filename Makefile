#.SILENT:

SMB = 0
#set SMB to 1 to build uLe with smb support

EE_BIN = BOOT-UNC.ELF
EE_BIN_PKD = BOOT.ELF
EE_OBJS = main.o pad.o config.o elf.o draw.o loader_elf.o filer.o \
	poweroff_irx.o iomanx_irx.o filexio_irx.o ps2atad_irx.o ps2dev9_irx.o ps2ip_irx.o\
	ps2smap_irx.o ps2hdd_irx.o ps2fs_irx.o ps2netfs_irx.o usbd_irx.o usbhdfsd_irx.o mcman_irx.o mcserv_irx.o\
	cdvd_irx.o ps2ftpd_irx.o ps2host_irx.o vmc_fs_irx.o ps2kbd_irx.o\
	hdd.o hdl_rpc.o hdl_info_irx.o editor.o timer.o jpgviewer.o icon.o lang.o\
	font_uLE.o makeicon.o chkesr.o sior_irx.o allowdvdv_irx.o
ifeq ($(SMB),1)
	EE_OBJS += smbman.o
endif

EE_INCS := -I$(PS2DEV)/gsKit/include -I$(PS2SDK)/ports/include -Ioldlibs/libcdvd/ee

EE_LDFLAGS := -L$(PS2DEV)/gsKit/lib -L$(PS2SDK)/ports/lib -Loldlibs/libcdvd/lib 
EE_LIBS = -lgskit -ldmakit -ljpeg -lpad -lmc -lhdd -lcdvdfs -lkbd -lmf \
	-lcdvd -lc -lfileXio -lpatches -lpoweroff -ldebug -lc -lsior
EE_CFLAGS := -mgpopt -G10240

ifeq ($(SMB),1)
	EE_CFLAGS += -DSMB
endif

.PHONY: all run reset clean rebuild

all: githash.h $(EE_BIN_PKD)

$(EE_BIN_PKD): $(EE_BIN)
	ps2-packer $< $@

run: all
	ps2client -h 192.168.0.10 -t 1 execee host:$(EE_BIN)
reset: clean
	ps2client -h 192.168.0.10 reset

githash.h:
	printf '#ifndef ULE_VERDATE\n#define ULE_VERDATE "' > $@ && \
	git show -s --format=%cd --date=local | tr -d "\n" >> $@ && \
	printf '"\n#endif\n' >> $@
	printf '#ifndef GIT_HASH\n#define GIT_HASH "' >> $@ && \
	git rev-parse --short HEAD | tr -d "\n" >> $@ && \
	printf '"\n#endif\n' >> $@

mcman_irx.s: $(PS2SDK)/iop/irx/mcman.irx
	bin2s $< $@ mcman_irx

mcserv_irx.c: $(PS2SDK)/iop/irx/mcserv.irx
	bin2c $< $@ mcserv_irx

usbd_irx.c: $(PS2SDK)/iop/irx/usbd.irx
	bin2c $< $@ usbd_irx

usbhdfsd_irx.c: $(PS2SDK)/iop/irx/usbhdfsd.irx
	bin2c $< $@ usb_mass_irx

oldlibs/libcdvd/lib/cdvd.irx: oldlibs/libcdvd
	$(MAKE) -C $<

cdvd_irx.c: oldlibs/libcdvd/lib/cdvd.irx
	bin2c $< $@ cdvd_irx

poweroff_irx.c: $(PS2SDK)/iop/irx/poweroff.irx
	bin2c $< $@ poweroff_irx

iomanx_irx.c: $(PS2SDK)/iop/irx/iomanX.irx
	bin2c $< $@ iomanx_irx

filexio_irx.c: $(PS2SDK)/iop/irx/fileXio.irx
	bin2c $< $@ filexio_irx

ps2dev9_irx.c: $(PS2SDK)/iop/irx/ps2dev9.irx
	bin2c $< $@ ps2dev9_irx

ps2ip_irx.c: $(PS2SDK)/iop/irx/ps2ip.irx
	bin2c $< $@ ps2ip_irx

ps2smap_irx.c: $(PS2DEV)/ps2eth/smap/ps2smap.irx
	bin2c $< $@ ps2smap_irx

oldlibs/ps2ftpd/bin/ps2ftpd.irx: oldlibs/ps2ftpd
	$(MAKE) -C $<

ps2ftpd_irx.c: oldlibs/ps2ftpd/bin/ps2ftpd.irx
	bin2c $< $@ ps2ftpd_irx

ps2atad_irx.c: $(PS2SDK)/iop/irx/ps2atad.irx
	bin2c $< $@ ps2atad_irx

ps2hdd_irx.c: $(PS2SDK)/iop/irx/ps2hdd-osd.irx
	bin2c $< $@ ps2hdd_irx

ps2fs_irx.c: $(PS2SDK)/iop/irx/ps2fs.irx
	bin2c $< $@ ps2fs_irx

ps2netfs_irx.c: $(PS2SDK)/iop/irx/ps2netfs.irx
	bin2c $< $@ ps2netfs_irx

hdl_info/hdl_info.irx: hdl_info
	$(MAKE) -C $<

hdl_info_irx.c: hdl_info/hdl_info.irx
	bin2c $< $@ hdl_info_irx

ps2host/ps2host.irx: ps2host
	$(MAKE) -C $<

ps2host_irx.c: ps2host/ps2host.irx
	bin2c $< $@ ps2host_irx

ifeq ($(SMB),1)
smbman_irx.c: $(PS2SDK)/iop/irx/smbman.irx
	bin2c $< $@ smbman_irx
endif

vmc_fs/vmc_fs.irx: vmc_fs
	$(MAKE) -C $<

vmc_fs_irx.c: vmc_fs/vmc_fs.irx
	bin2c $< $@ vmc_fs_irx

loader/loader.elf: loader
	$(MAKE) -C $<

loader_elf.c: loader/loader.elf
	bin2c $< $@ loader_elf

ps2kbd_irx.c: $(PS2SDK)/iop/irx/ps2kbd.irx
	bin2c $< $@ ps2kbd_irx

sior_irx.c: $(PS2SDK)/iop/irx/sior.irx
	bin2c $< $@ sior_irx

AllowDVDV/AllowDVDV.irx: AllowDVDV
	$(MAKE) -C $<

allowdvdv_irx.c: AllowDVDV/AllowDVDV.irx
	bin2c $< $@ allowdvdv_irx

clean:
	$(MAKE) -C hdl_info clean
	$(MAKE) -C ps2host clean
	$(MAKE) -C loader clean
	$(MAKE) -C vmc_fs clean
	$(MAKE) -C AllowDVDV clean
	$(MAKE) -C oldlibs/libcdvd clean
	$(MAKE) -C oldlibs/ps2ftpd clean
	rm -f githash.h *_irx.c *_elf.c $(EE_OBJS) $(EE_BIN) $(EE_BIN_PKD)

rebuild: clean all

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
