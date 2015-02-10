SRCSMAIN = Saint.cc

SRCROOT := $(shell pwd)
INCLUDES = -I$(SRCROOT)

EXEC = saint
TRACEFLAGS = -rdynamic
CFLAGS = -Wall -g $(TRACEFLAGS) -std=c++11
CC = g++

OBJDIR=$(SRCROOT)/build
MAINOBJECT = $(SRCSMAIN:%.cc=%.o)
MOBJPTH = $(addprefix $(OBJDIR)/, $(MAINOBJECT))

.PHONY: prepare clean $(EXEC)

all: prepare $(SRCSMAIN) $(EXEC)

prepare:
	mkdir -p $(OBJDIR)
	@echo "setup build directory $(OBJDIR)"

$(EXEC): $(MAINOBJECT)
	$(CC) $(CFLAGS) $(MOBJPTH) -o $(OBJDIR)/$@
	@echo "done linking executable $(EXEC)"

%.o: %.cc
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$@
	@echo "done generating object $@"

clean:
	rm -rf $(OBJDIR)
	@echo "removed object directory $(OBJDIR)"

