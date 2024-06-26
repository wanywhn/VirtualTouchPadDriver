KERNEL_VERSION :=$(shell uname -r)
KERNEL_MODULES :=/lib/modules/$(KERNEL_VERSION)/build
obj-m += virtual_touchpad.o

dkms_name:="virtual-touchpad"
dkms_version:="1.1.0"
DIR:=`pwd`


.PHONY: all clean install dkms dkms_clean

all:
	make -C $(KERNEL_MODULES) M=$(PWD) modules

clean:
	make -C $(KERNEL_MODULES) M=$(PWD) clean


install:
	cp virtual_touchpad.ko /lib/modules/`uname -r`/kernel/drivers/input/mouse
	cp vtp-driver.init /etc/init.d/vtp-driver
	chmod +x /etc/init.d/vtp-driver
	update-rc.d vtp-driver defaults
	depmod -a


dkms:
	#add
	if ! dkms status -m $(dkms_name) -v $(dkms_version) | egrep '(added|built|installed)' >/dev/null ; then\
		dkms add  ${DIR}; \
	fi
	#build
	#if ! dkms status -m $(dkms_name) -v $(dkms_version)  | egrep '(built|installed)' >/dev/null ; then\
		dkms build $(dkms_name)/$(dkms_version); \
	#fi
	#mkdeb
	#dkms mktarball -m $(dkms_name) -v $(dkms_version)  --source-only
	#dkms mkdsc -m $(dkms_name) -v $(dkms_version) --source-only
	dkms mkdeb -m $(dkms_name) -v $(dkms_version) --source-only

dkms_clean:
	# if dkms bindings exist, remove them
	if dkms status -m $(dkms_name) -v $(dkms_version) | egrep '(added|built|installed)' >/dev/null ; then\
		dkms remove $(dkms_name)/$(dkms_version) --all; \
	fi
