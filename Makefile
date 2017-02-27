TARGETS=all check clean clobber distclean install uninstall
TARGET=all

PREFIX=${DESTDIR}/opt
BINDIR=${PREFIX}/bin
SUBDIRS=

INSTALL=install

.PHONY: ${TARGETS} ${SUBDIRS}

GCC	=gcc
CFLAGS	=-Os -Wall -Werror -pedantic -g
LDFLAGS	=-g
LDLIBS	=-lldns

all::	ldns-mx

${TARGETS}::

clean::
	${RM} *.o a.out core.* lint tags

clobber distclean:: clean
	${RM} ldns-mx

check::	ldns-mx
	./ldns-mx ${ARGS}

install:: ldns-mx
	${INSTALL} -D ldns-mx ${BINDIR}/ldns-mx

uninstall::
	${RM} ${BINDIR}/ldns-mx

ifneq	(,${SUBDIRS})
${TARGETS}::
	${MAKE} TARGET=$@ ${SUBDIRS}
${SUBDIRS}::
	${MAKE} -C $@ ${TARGET}
endif
