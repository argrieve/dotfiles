# Generic Makefile for Assembly/C/C++ that supports separate build
# and source directores, automatic dependency tracking, and auto-
# matic generation of include directory flags. Commands:
#
# 'make'         build executable file
# 'make clean'   removes all .o files and the executable

# define the executable
MAIN = a.out

# define the compilers
AS = gcc
CC = gcc
CXX = g++

# define compile-time flags
ASFLAGS =
CFLAGS = -Wall
CXXFLAGS = -std=c++11

# define flags for dependency generation
DEP_FLAGS = -MMD -MP

# define the source and build directory names
BUILD_DIR = ./build
SRC_DIR = .

# define source, object, and dependency files 
SRCS = $(shell find $(SRC_DIR) -name '*.s' -or -name '*.c' -or -name '*.cpp')
#OBJS = $(SRCS:%=$(BUILD_DIR)/%.o)
OBJS = $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%.o,$(SRCS))
DEPS = $(OBJS:.o=.d)

# define directories containing header files other than /usr/include
#   automatically finds all directories under the source directory
#   and then prefixes them with -I
INC_DIRS = $(shell find $(SRC_DIR) -type d -not -path $(BUILD_DIR))
INC_FLAGS = $(addprefix -I,$(INC_DIRS))

# define library paths in addition to /usr/lib (-Lpath)
LDFLAGS +=

# define libraries to link into executable (ex: -lm)
LDLIBS +=

# debug: print the value of variables
#$(info SRCS is $(SRCS))
#$(info OBJS is $(OBJS))
#$(info DEPS is $(DEPS))
#$(info INC_FLAGS is $(INC_FLAGS))
#$(info LDFLAGS is $(LDFLAGS))
#$(info LDLIBS is $(LDLIBS))

# shell commands
MKDIR_P = mkdir -p

all: $(MAIN)
#	cp $(BUILD_DIR)/$(MAIN) .
	@echo Program $(MAIN) has been compiled. 

# linking
$(MAIN): $(OBJS)
	$(CXX) $(OBJS) -o $(BUILD_DIR)/$@ $(LDFLAGS) $(LDLIBS)

# assembly
#$(BUILD_DIR)/%.s.o: %.s
$(BUILD_DIR)/%.s.o: $(SRC_DIR)/%.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
#$(BUILD_DIR)/%.c.o: %.c
$(BUILD_DIR)/%.c.o: $(SRC_DIR)/%.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(INC_FLAGS) $(DEP_FLAGS) $(CFLAGS) -c $< -o $@

# c++ source
#$(BUILD_DIR)/%.cpp.o: %.cpp
$(BUILD_DIR)/%.cpp.o: $(SRC_DIR)/%.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(INC_FLAGS) $(DEP_FLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(MAIN)

-include $(DEPS)

