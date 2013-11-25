PREFIX?=/usr/local
INSTALL_BIN= $(PREFIX)/bin
#CFLAGS=-DDEBUG -g

#CFLAGS=-I/home/brook/openwrt/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/usr/include
#LDFLAGS=-L/home/brook/openwrt/openwrt/staging_dir/target-mips_34kc_uClibc-0.9.33.2/usr/lib

all:baidu_pcs

baidu_pcs:
	$(CC) $(CFLAGS) $(LDFLAGS) -Wall -O2 baidu_pcs.c pcs.c pcs_file.c cJSON.c http_client.c -o ./bin/baidu_pcs -lcurl -lm

install:baidu_pcs
	mkdir -p $(INSTALL_BIN)
	cp ./baidu_pcs $(INSTALL_BIN)/baidu_pcs
	chmod 755 $(INSTALL_BIN)/baidu_pcs

clean:
	rm ./baidu_pcs
