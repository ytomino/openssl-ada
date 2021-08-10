SOURCEDIR=../source

HOST:=$(shell gcc -dumpmachine)
TARGET=$(HOST)

BUILDDIR=$(TARGET).noindex

ifeq ($(TARGET),$(HOST))
GCCPREFIX=
BINLN=bin
else
GCCPREFIX=$(TARGET)-
BINLN=
endif
GCCSUFFIX=
GCC=$(GCCPREFIX)gcc$(GCCSUFFIX)

GFLAGS=
CFLAGS=-ggdb -pipe -gnata -gnatef -gnatwa -gnatyy-3chbs \
	$(addprefix -gnatec=,$(abspath $(wildcard *.adc)))
MFLAGS=-C -D $(BUILDDIR) -gnatA
BFLAGS=-E
LFLAGS=-ggdb
HFLAGS=

ifneq ($(DRAKE_RTSROOT),)
VERSION:=$(shell $(GCC) -dumpversion)
DRAKE_RTSDIR=$(DRAKE_RTSROOT)/$(TARGET)/$(VERSION)
endif
ifneq ($(DRAKE_RTSDIR),)
IMPORTDIR=
GFLAGS+=--RTS=$(abspath $(DRAKE_RTSDIR))
else
ifneq ($(wildcard import/$(TARGET)),)
IMPORTDIR=import/$(TARGET)
else
IMPORTDIR=$(BUILDDIR)/import
endif
MFLAGS+=-I$(IMPORTDIR)
endif

ifneq ($(GCC),gcc)
GFLAGS+=$(filter -m32 -m64,$(GCC))
MFLAGS+=--GCC="$(GCC)"
LFLAGS+=--GCC="$(GCC)"
HFLAGS+=-gcc="$(GCC)"
endif

EXAMPLES=$(basename $(filter-out b~%,$(wildcard *.adb)))

.PHONY: all clean $(EXAMPLES)

all: $(EXAMPLES)

$(BUILDDIR)/%: %.adb $(IMPORTDIR) $(wildcard $(SOURCEDIR)/*) | $(BUILDDIR)
	$(GCCPREFIX)gnatmake$(GCCSUFFIX) -c -I$(SOURCEDIR) $< $(GFLAGS) $(MFLAGS) -cargs $(CFLAGS)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatbind$(GCCSUFFIX) $(basename $(notdir $<)).ali $(GFLAGS) $(BFLAGS)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatlink$(GCCSUFFIX) -o ../$@ $(basename $(notdir $<)).ali $(GFLAGS) $(LFLAGS)

$(BUILDDIR):
	mkdir $@

$(BINLN): | $(BUILDDIR)
	ln -s $(BUILDDIR) $@

$(EXAMPLES): %: $(BUILDDIR)/% $(BINLN)

ifeq ($(IMPORTDIR),$(BUILDDIR)/import)
$(IMPORTDIR): $(SOURCEDIR)/import.h | $(BUILDDIR)
	headmaster --to ada $(HFLAGS) -p -D $@ $+
	touch $@
endif

clean:
	-rm -rf *.noindex bin
