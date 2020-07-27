# Location of the ESMF makefile fragment for this component:
datm_mk = $(CDEPS_BINDIR)/datm.mk
all_component_mk_files+=$(datm_mk)

# Location of source code and installation
CDEPS_SRCDIR?=$(ROOTDIR)/CDEPS
CDEPS_BINDIR?=$(ROOTDIR)/CDEPS_INSTALL
CDEPS_LIBSRCDIR=$(CDEPS_SRCDIR)LIB

# Make sure the expected directories exist and are non-empty:
$(call require_dir,$(CDEPS_SRCDIR),CDEPS source directory)

CDEPS_ALL_FLAGS=\
  COMP_SRCDIR="$(CDEPS_SRCDIR)" \
  COMP_BINDIR="$(CDEPS_BINDIR)"

# Rule for building this component:
build_CDEPS: $(datm_mk)

$(datm_mk): configure
	+$(MODULE_LOGIC) ; cd $(CDEPS_SRCDIR) ; exec $(MAKE) $(CDEPS_ALL_FLAGS)
	+$(MODULE_LOGIC) ; cd $(CDEPS_SRCDIR) ; exec $(MAKE) $(CDEPS_ALL_FLAGS) \
	    DESTDIR=/ "INSTDIR=$(CDEPS_BINDIR)" install
	test -d "$(CDEPS_BINDIR)"

# Rule for cleaning the SRCDIR and BINDIR:
clean_CDEPS:
	+cd $(CDEPS_SRCDIR) ; exec $(MAKE) -k clean

distclean_CDEPS: clean_CDEPS
	rm -rf $(CDEPS_BINDIR) $(datm_mk)

