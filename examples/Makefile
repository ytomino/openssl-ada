SOURCEDIR=../source

HOST:=$(shell gcc -dumpmachine)
TARGET=$(HOST)

BUILDDIR=$(TARGET).noindex

ifneq ($(TARGET),$(HOST))
 GCCPREFIX=$(TARGET)-
 BINLN=
else
 GCCPREFIX=
 BINLN=bin
endif
GCCSUFFIX=
GCC=$(GCCPREFIX)gcc$(GCCSUFFIX)

CFLAGS=-ggdb -pipe
CFLAGS_ADA=-gnata -gnatef -gnatwa -gnatyy-3bchms
LDFLAGS=-ggdb
HFLAGS=

ifeq ($(TARGET),$(HOST))
 WITH_SSL?=
 ifneq ($(WITH_SSL),)
  SSL_LDFLAGS=-L$(WITH_SSL)/lib
  SSL_HFLAGS=-I$(WITH_SSL)/include
 else
  SSL_LDFLAGS:=$(shell pkg-config --libs-only-L libcrypto)
  SSL_HFLAGS:=$(shell pkg-config --cflags-only-I libcrypto)
 endif
 LDFLAGS+=$(SSL_DLFLAGS)
 HFLAGS+=$(SSL_HFLAGS)
endif

ifneq ($(DRAKE_RTSROOT),)
 VERSION:=$(shell $(GCC) -dumpversion)
 DRAKE_RTSDIR=$(DRAKE_RTSROOT)/$(TARGET)/$(VERSION)
endif
ifneq ($(DRAKE_RTSDIR),)
 IMPORTDIR=
else
 ifneq ($(wildcard import/$(TARGET)),)
  IMPORTDIR=import/$(TARGET)
 else
  IMPORTDIR=$(BUILDDIR)/import
 endif
endif

GARGS=$(addprefix --RTS=,$(abspath $(DRAKE_RTSDIR)))
MARGS=-D $(BUILDDIR) -gnatA $(addprefix -gnatec=,$(wildcard *.adc)) \
      $(addprefix -I,$(IMPORTDIR))
CARGS=$(CFLAGS) $(CFLAGS_ADA)
BARGS=-E
LARGS=$(LDFLAGS)

ifneq ($(GCC),gcc)
 HFLAGS+=-gcc="$(GCC)"
 GARGS+=$(filter -m32 -m64,$(GCC))
 MARGS+=--GCC="$(GCC)"
 LARGS+=--GCC="$(GCC)"
endif

EXAMPLES=$(basename $(filter-out b~%,$(wildcard *.adb)))
TESTS=$(filter test_%,$(EXAMPLES))

.PHONY: all check clean $(EXAMPLES)

all: $(addprefix $(BUILDDIR)/,$(EXAMPLES)) $(BINLN)

$(BUILDDIR)/%: %.adb $(IMPORTDIR) $(wildcard $(SOURCEDIR)/*) | $(BUILDDIR)
	$(GCCPREFIX)gnatmake$(GCCSUFFIX) -c -I$(SOURCEDIR) $< $(GARGS) $(MARGS) \
		-cargs $(CARGS)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatbind$(GCCSUFFIX) \
		$(basename $(notdir $<)).ali $(GARGS) $(BARGS)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatlink$(GCCSUFFIX) -o ../$@ \
		$(basename $(notdir $<)).ali $(GARGS) $(LARGS)

$(BUILDDIR):
	mkdir $@

$(BINLN): | $(BUILDDIR)
	ln -s $(BUILDDIR) $@

$(filter-out test_%,$(EXAMPLES)): %: $(BUILDDIR)/% $(BINLN)

check: all $(TESTS)

$(TESTS): %: $(BUILDDIR)/%
	$<

ifeq ($(IMPORTDIR),$(BUILDDIR)/import)
$(IMPORTDIR): $(SOURCEDIR)/import.h | $(BUILDDIR)
	headmaster --to ada $(HFLAGS) -p -D $@ $+
	touch $@
endif

clean:
	-rm -r *.noindex bin
