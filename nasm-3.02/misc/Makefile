# -*- makefile -*-
# SPDX-License-Identifier: BSD-2-Clause
# Copyright 1996-2025 The NASM Authors - All Rights Reserved

#
# Makefile for various extra NASM programs and files
#



top_srcdir	= ..
srcdir		= .
top_objdir	= ..
objdir		= .

prefix		= /usr
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
mandir		= ${datarootdir}/man
docdir		= ${datarootdir}/doc/${PACKAGE_TARNAME}
htmldir		= ${docdir}
infodir		= ${datarootdir}/info
datarootdir	= ${prefix}/share

datadir		= $(datarootdir)/nasm

CC		= gcc
CFLAGS		= -g -O2 -std=c17 -U__STRICT_ANSI__ -g3 -ggdb -fwrapv -ftrivial-auto-var-init=zero -fno-common -ffunction-sections -fdata-sections -fvisibility=hidden -Wall -W -pedantic -Werror=implicit -Werror=missing-braces -Werror=return-type -Werror=trigraphs -Werror=pointer-arith -Werror=comment -Werror=vla -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Wno-variadic-macros -Wno-long-long -Wno-stringop-truncation -Wno-shift-negative-value
CPPFLAGS	=  -Werror=attributes
BUILD_CFLAGS	= $(CPPFLAGS) $(CFLAGS) -DHAVE_CONFIG_H
INTERNAL_CFLAGS = -I$(srcdir) -I$(objdir) \
		  -I$(top_srcdir) -I$(top_objdir) \
		  -I$(top_srcdir)/include -I$(top_objdir)/include \
		  -I$(top_srcdir)/config  -I$(top_objdir)/config
ALL_CFLAGS	= $(BUILD_CFLAGS) $(INTERNAL_CFLAGS)
LDFLAGS		=  -Wl,--as-needed -Wl,--gc-sections
ALL_LDFLAGS     = $(ALL_CFLAGS) $(LDFLAGS)
LIBS		= -lz 

INSTALL		= /usr/bin/install -c
INSTALL_PROGRAM	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644

PERL		= perl
RUNPERL		= $(PERL) -I$(top_srcdir)/perllib -I$(srcdir)

MKDIR_P		= /usr/bin/mkdir -p
RM_F		= rm -f
RM_RF		= rm -rf
CP_F		= cp -f
CP_UF		= cp -uf

PROGS		= omfdump$(X)
GENDATA		=
SRCDATA		= README \
		  c16.mac c32.mac exebin.mac exebin2.mac \
		  myC32.mac scitech.mac \
		  nasmstab

# Binary suffixes
O		= o
X		= 
A		= a

# Don't delete intermediate files
.SECONDARY:

# Delete files on error
.DELETE_ON_ERROR:

.SUFFIXES:
.SUFFIXES:	.$(O) .$(A) $(X) .c .i .s

all: $(PROGS) $(GENDATA)

.c.$(O):
	$(CC) $(ALL_CFLAGS) -c -o $@ $<

.c.s:
	$(CC) $(ALL_CFLAGS) -S -o $@ $<

.c.i:
	$(CC) $(ALL_CFLAGS) -E -o $@ $<

omfdump$(X): omfdump.$(O)
	$(CC) $(ALL_LDFLAGS) -o $@ $< $(LIBS)

install-prog: $(PROGS)
	$(MKDIR_P) $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) $(PROGS) $(DESTDIR)$(bindir)/

DATAFILES = $(GENDATA) $(SRCDATA:%=$(srcdir)/%)

install-data: $(DATAFILES)
	$(MKDIR_P) $(DESTDIR)$(datadir)
	$(INSTALL_DATA) $(DATAFILES) $(DESTDIR)$(datadir)/

install: install-prog install-data

clean:
	-$(RM_F) *.$(O) *.$(A) $(PROGS) $(GENDATA)

spotless: clean

Makefile: Makefile.in ../config.status
	$(SHELL) ../config.status
