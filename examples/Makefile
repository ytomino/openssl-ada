HOST=$(shell gcc -dumpmachine)
TARGET=$(HOST)

VERSION=$(shell gcc -dumpversion)

BUILDDIR=$(TARGET).build

ifeq ($(TARGET),$(HOST))
GNATPREFIX=
GCC=$(dir $(shell which gnatmake))gcc
BINLN=bin
else
GNATPREFIX=$(TARGET)-
GCC=$(TARGET)-gcc
BINLN=
endif

GFLAGS=
GFLAGS_ALL=
CFLAGS=
CFLAGS_ALL=-ggdb -pipe -gnata -gnatef -gnatwa -gnatyy-3chbs
MFLAGS=
MFLAGS_ALL=-C -D $(BUILDDIR) -I../source
BFLAGS=
BFLAGS_ALL=-E
LFLAGS=
LFLAGS_ALL=-ggdb

ifneq ($(DRAKE_RTSROOT),)
DRAKE_RTSDIR=$(DRAKE_RTSROOT)/$(TARGET)/$(VERSION)
endif
ifneq ($(DRAKE_RTSDIR),)
IMPORTDIR=
GFLAGS_ALL+=--RTS=$(abspath $(DRAKE_RTSDIR))
else
IMPORTDIR=$(BUILDDIR)/import
MFLAGS_ALL+=-I$(IMPORTDIR)
endif

GFLAGS_ALL:=$(strip $(GFLAGS_ALL) $(GFLAGS))
CFLAGS_ALL:=$(strip $(CFLAGS_ALL) $(CFLAGS))
MFLAGS_ALL:=$(strip $(MFLAGS_ALL) $(MFLAGS))
BFLAGS_ALL:=$(strip $(BFLAGS_ALL) $(BFLAGS))
LFLAGS_ALL:=$(strip $(LFLAGS_ALL) $(LFLAGS))
FFLAGS_ALL:=$(strip $(FFLAGS_ALL) $(FFLAGS))

EXAMPLES=$(basename $(filter-out b~%,$(wildcard *.adb)))

.PHONY: all clean $(EXAMPLES)

all: $(BUILDDIR)/test_md5 $(BUILDDIR)/test_sha1

$(BUILDDIR)/%: %.adb $(IMPORTDIR) $(wildcard ../source/*) | $(BUILDDIR)
	$(GNATPREFIX)gnatmake -c $< $(GFLAGS_ALL) $(MFLAGS_ALL) -cargs $(CFLAGS_ALL)
	cd $(BUILDDIR) && $(GNATPREFIX)gnatbind $(basename $(notdir $<)).ali $(GFLAGS_ALL) $(BFLAGS_ALL)
	cd $(BUILDDIR) && $(GNATPREFIX)gnatlink -o ../$@ $(basename $(notdir $<)).ali $(GFLAGS_ALL) $(LFLAGS_ALL)

$(BUILDDIR):
	mkdir $(BUILDDIR)

$(BINLN): | $(BUILDDIR)
	ln -s $(BUILDDIR) $(BINLN)

$(EXAMPLES): %: $(BUILDDIR)/% $(BINLN)

ifeq ($(IMPORTDIR),$(BUILDDIR)/import)
$(IMPORTDIR): ../source/import.h | $(BUILDDIR)
	headmaster --to ada -gcc=$(GCC) $(addprefix -isystem ,$(INCDIR)) -p -D $(IMPORTDIR) $+
endif

clean:
	-rm -rf *.build bin
