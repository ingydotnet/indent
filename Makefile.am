## Process this file with automake to produce Makefile.in
AUTOMAKE_OPTIONS = no-texinfo.tex

SUBDIRS = intl src doc po man regression

BUILT_SOURCES = 

DISTFILES = $(DIST_COMMON:README=README.md) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)

EXTRA_DIST = 	README.md \
		config/config.rpath config/mkinstalldirs \
		ChangeLog-1990 ChangeLog-1998 ChangeLog-2001 \
		aclocal/UTIMBUF.m4 \
		miscel/Makefile.mingw32 \
		miscel/README.vc++ \
		bootstrap \
		regression

DISTCLEANFILES=config/config.cache config/config.log config.h

ps:
	cd doc && $(MAKE) @PACKAGE@.ps

pdf:
	cd doc && $(MAKE) @PACKAGE@.pdf

html:
	cd doc && $(MAKE) html

html-split:
	cd doc && $(MAKE) html-split

# --------------- Maintainer's Section

MAINTAINERCLEANFILES = intl/* aclocal.m4 Makefile.in \
	config.h.in config/* \
	po/Makefile.in.in po/Rules-quot po/boldquot.sed po/en@boldquot.header \
	po/en@quot.header po/insert-header.sin po/quot.sed po/remove-potcdate.sin \
	stamp-h1 stamp-h.in configure \
	@PACKAGE@-1.spec \
	@PACKAGE@.lsm indent-2.spec .gdbinit \
	INSTALL ABOUT-NLS 

## Use -g when in maintainer mode
if MAINTAINER_MODE
CFLAGS+= -g -Wall -I.
else
CFLAGS+= -I.
endif

if MAINTAINER_MODE
README: README.md
	ln -s $< $@

@PACKAGE@.lsm :%: Makefile %.in
	sed -e 's%!VERSION!%@VERSION@%g' $@.in > $@

tar:
	$(MAKE) dist
	install -D @PACKAGE@-@VERSION@.tar.gz $(REDHAT)/SOURCES/@PACKAGE@-@VERSION@.tar.gz

WWWDIR=/home/david/www/@PACKAGE@
REDHAT=$(shell grep '^%_topdir' rpm/macros | cut -d \  -f 2)
SPECFILE=@PACKAGE@-${shell echo "@VERSION@" | cut -d. -f1}.spec

rpm: tar $(SPECFILE)
	rpm --rcfile=/usr/lib/rpm/rpmrc:rpm/rpmrc --target=$(TARGET) --sign --clean -ba $(SPECFILE)

$(SPECFILE): rpm/$(SPECFILE).in configure.ac
	cvs commit rpm/$(SPECFILE).in
	sed -e 's/!VERSION!/@VERSION@/g' rpm/$(SPECFILE).in | grep -B2000 '!CHANGELOG!' | grep -v '!CHANGELOG!' > $(SPECFILE)
	echo -n "%changelog" >> $(SPECFILE)
	cvs log rpm/$(SPECFILE).in | \
	  grep -A2000 '^-----' | \
	  egrep -v '^-----|^=====|^revision' | \
	  awk -F'[ ;]' --assign lastdate="" '{ if ($$0~/^date: /) { \
	    if (lastdate != $$2) { \
	      lastdate=$$2; \
	      printf("\n* "); \
	      system("echo -n `date --date \""$$2" "$$3"\" \"+%a %b %d %Y\"`"); \
	      printf(" $(AUTHOR)\n"); \
	    } \
	  } else if ($$0~/^[A-Z]/) { printf("- %s\n", $$0); } else if ($$0~/./) { printf("  %s\n", $$0); } else {print} }' >> $(SPECFILE)
	grep -A2000 '!CHANGELOG!' rpm/$(SPECFILE).in | grep -v '!CHANGELOG!' >> $(SPECFILE)

endif


ACLOCAL_AMFLAGS = -I m4
