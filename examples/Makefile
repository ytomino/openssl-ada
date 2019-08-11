SOURCEDIR=../source

HOST:=$(shell gcc -dumpmachine)
TARGET=$(HOST)

BUILDDIR=$(TARGET).build

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
GFLAGS_ALL=
CFLAGS=
CFLAGS_ALL=-ggdb -pipe -gnata -gnatef -gnatwa -gnatyy-3chbs \
	$(addprefix -gnatec=,$(abspath $(wildcard *.adc)))
MFLAGS=
MFLAGS_ALL=-C -D $(BUILDDIR) -gnatA
BFLAGS=
BFLAGS_ALL=-E
LFLAGS=
LFLAGS_ALL=-ggdb

ifneq ($(DRAKE_RTSROOT),)
VERSION:=$(shell $(GCC) -dumpversion)
DRAKE_RTSDIR=$(DRAKE_RTSROOT)/$(TARGET)/$(VERSION)
endif
ifneq ($(DRAKE_RTSDIR),)
IMPORTDIR=
GFLAGS_ALL+=--RTS=$(abspath $(DRAKE_RTSDIR))
else
IMPORTDIR=$(BUILDDIR)/import
MFLAGS_ALL+=-I$(IMPORTDIR)
endif

ifneq ($(GCC),gcc)
GFLAGS_ALL+=$(filter -m32 -m64,$(GCC))
MFLAGS_ALL+=--GCC="$(GCC)"
LFLAGS_ALL+=--GCC="$(GCC)"
HFLAGS+=-gcc="$(GCC)"
endif

GFLAGS_ALL:=$(strip $(GFLAGS_ALL) $(GFLAGS))
CFLAGS_ALL:=$(strip $(CFLAGS_ALL) $(CFLAGS))
MFLAGS_ALL:=$(strip $(MFLAGS_ALL) $(MFLAGS))
BFLAGS_ALL:=$(strip $(BFLAGS_ALL) $(BFLAGS))
LFLAGS_ALL:=$(strip $(LFLAGS_ALL) $(LFLAGS))
FFLAGS_ALL:=$(strip $(FFLAGS_ALL) $(FFLAGS))

EXAMPLES=$(basename $(filter-out b~%,$(wildcard *.adb)))

.PHONY: all clean $(EXAMPLES)

all: $(EXAMPLES)

$(BUILDDIR)/%: %.adb $(IMPORTDIR) $(wildcard $(SOURCEDIR)/*) | $(BUILDDIR)
	$(GCCPREFIX)gnatmake$(GCCSUFFIX) -c -I$(SOURCEDIR) $< $(GFLAGS_ALL) $(MFLAGS_ALL) -cargs $(CFLAGS_ALL)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatbind$(GCCSUFFIX) $(basename $(notdir $<)).ali $(GFLAGS_ALL) $(BFLAGS_ALL)
	cd $(BUILDDIR) && $(GCCPREFIX)gnatlink$(GCCSUFFIX) -o ../$@ $(basename $(notdir $<)).ali $(GFLAGS_ALL) $(LFLAGS_ALL)

$(BUILDDIR):
	mkdir $(BUILDDIR)

$(BINLN): | $(BUILDDIR)
	ln -s $(BUILDDIR) $(BINLN)

$(EXAMPLES): %: $(BUILDDIR)/% $(BINLN)

ifeq ($(IMPORTDIR),$(BUILDDIR)/import)
$(IMPORTDIR): $(SOURCEDIR)/import.h | $(BUILDDIR)
	headmaster --to ada $(addprefix -isystem ,$(INCDIR)) $(HFLAGS) -p -D $(IMPORTDIR) $+
endif

clean:
	-rm -rf *.build bin
