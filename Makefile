ARCH=all
PKG_NAME=tftpd-dynamic
PKG_VERSION=1.4-2
PKG=$(PKG_NAME)_$(PKG_VERSION)_$(ARCH).deb

all: $(PKG_NAME)

$(PKG_NAME): $(PKG)

$(PKG): $(PKG_NAME)/DEBIAN/control $(PKG_NAME)/usr/bin/$(PKG_NAME)
	fakeroot dpkg-deb --build $(PKG_NAME) $@

$(PKG_NAME)/DEBIAN/control: Makefile
	@if [ "`grep "Version:" $@ | awk '{print $$2}'`" != "$(PKG_VERSION)" ] ; then \
		sed -i -e "s:Version\:.*:Version\: $(PKG_VERSION):g" $@ ; \
		if [ -e $@-e ] ; then rm $@-e ; fi ; \
	fi

$(PKG_NAME)/usr/bin/$(PKG_NAME): Makefile
	@if [ "`grep "pkgversion =" $@ | awk '{print $$3}'`" != "\"$(PKG_VERSION)\"" ] ; then \
		sed -i -e "s:pkgversion =.*:pkgversion = \"$(PKG_VERSION)\":g" $@ ; \
		if [ -e $@-e ] ; then rm $@-e ; fi ; \
	fi
