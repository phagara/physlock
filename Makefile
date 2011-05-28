all: physlock

VERSION=git-20110528

CC?=gcc
PREFIX?=/usr/local
CFLAGS+= -std=c99 -Wall -pedantic -DVERSION=\"$(VERSION)\"
LDFLAGS+= 
LIBS+= -lcrypt

SRCFILES=$(wildcard *.c)
OBJFILES=$(SRCFILES:.c=.o)

physlock:	$(OBJFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<

install: all
	install -D -m 4755 -o root -g root physlock $(PREFIX)/sbin/physlock
	mkdir -p $(PREFIX)/share/man/man1
	sed "s/VERSION/$(VERSION)/g" physlock.1 > $(PREFIX)/share/man/man1/physlock.1
	chmod 644 $(PREFIX)/share/man/man1/physlock.1

clean:
	rm -f physlock *.o

tags: *.h *.c
	ctags $^

cscope: *.h *.c
	cscope -b
