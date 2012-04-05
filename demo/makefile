SOURCEDIR=../source

HOST=$(shell gcc -dumpmachine)
TARGET=$(HOST)

ifeq ($(TARGET),$(HOST))
GNATMAKE=gnatmake
GCC=$(dir $(shell which $(GNATMAKE)))gcc
BUILDDIR=build
IMPORTDIR:=import
else
GNATMAKE=$(TARGET)-gnatmake
GCC=$(TARGET)-gcc
BUILDDIR=build-$(TARGET)
IMPORTDIR:=import-$(TARGET)
endif

ifneq ($(DRAKE_RTSROOT),)
DRAKE_RTSDIR=$(DRAKE_RTSROOT)/$(TARGET)
endif
ifneq ($(DRAKE_RTSDIR),)
IMPORTDIR:=
MFLAGS=--RTS=$(abspath $(DRAKE_RTSDIR))
endif

CFLAGS=-gnata -gnatwa -gnatyy-3chbs

.PHONY: all clean

all: $(BUILDDIR)/test_md5 $(BUILDDIR)/test_sha1

$(BUILDDIR)/%: %.adb $(BUILDDIR) $(IMPORTDIR) $(wildcard $(SOURCEDIR)/*)
	cd $(BUILDDIR) && $(GNATMAKE) -g $(MFLAGS) -I../$(SOURCEDIR) -I../$(IMPORTDIR) $(CFLAGS) ../$< -largs $(LFLAGS)

$(BUILDDIR):
	mkdir $(BUILDDIR)

ifneq ($(IMPORTDIR),)
$(IMPORTDIR): $(SOURCEDIR)/import.h
	headmaster --to ada -gcc=$(GCC) $(addprefix -isystem ,$(INCDIR)) -p -D $(IMPORTDIR) $+
endif

clean:
	-rm -rf build* import*
