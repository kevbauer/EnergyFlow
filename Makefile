CXX = g++
ifeq ($(shell uname), Darwin)
  CXX = clang++
endif
CXXFLAGS = -std=c++11 -g -Wall -O3

SRCDIR = src
INCLUDEDIR = include
TMPDIR = tmp
BINDIR = bin

ifeq (,$(findstring clean, $(MAKECMDGOALS)))
  $(shell mkdir -p $(TMPDIR) $(BINDIR))
 endif

INCLUDES = -I$(INCLUDEDIR)
LIBS = -ltaco
LDFLAGS = 

SRCS = $(wildcard $(SRCDIR)/*.cc)
OBJS = $(patsubst $(SRCDIR)/%.cc,$(TMPDIR)/%.o,$(SRCS))
MAIN = test

$(BINDIR)/$(MAIN): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) $(LIBS)

$(TMPDIR)/%.o: $(SRCDIR)/%.cc
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: clean
clean:
	rm -rfv $(BINDIR) $(TMPDIR) 
	