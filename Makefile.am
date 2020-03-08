AUTOMAKE_OPTIONS = subdir-objects

if WANT_JANSSON
JANSSON_INCLUDES= -I$(top_srcdir)/compat/jansson
else
JANSSON_INCLUDES=
endif

EXTRA_DIST			= example-cfg.json

SUBDIRS					= compat

bin_PROGRAMS		= minerd

dist_man_MANS		= minerd.1

minerd_SOURCES	=	elist.h miner.h compat.h \
									cpu-miner.c util.c \
									cpuinfo.c \
									sha2.c \
									yespower-1.0.1/sha256.c yespower-1.0.1/yespower-opt.c YespowerSugar.c

minerd_LDFLAGS	= $(PTHREAD_FLAGS)
minerd_LDADD		= @LIBCURL@ @JANSSON_LIBS@ @PTHREAD_LIBS@ @WS2_LIBS@
minerd_CPPFLAGS	= $(PTHREAD_FLAGS) @CPPFLAGS@ $(JANSSON_INCLUDES)

