# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alex/vms/YaRPO/Assembler/share/asm-scal

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию"

# Include any dependencies generated for this target.
include CMakeFiles/asm-scal.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/asm-scal.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/asm-scal.dir/flags.make

CMakeFiles/asm-scal.dir/main.c.o: CMakeFiles/asm-scal.dir/flags.make
CMakeFiles/asm-scal.dir/main.c.o: /home/alex/vms/YaRPO/Assembler/share/asm-scal/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/asm-scal.dir/main.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/asm-scal.dir/main.c.o   -c /home/alex/vms/YaRPO/Assembler/share/asm-scal/main.c

CMakeFiles/asm-scal.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/asm-scal.dir/main.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/alex/vms/YaRPO/Assembler/share/asm-scal/main.c > CMakeFiles/asm-scal.dir/main.c.i

CMakeFiles/asm-scal.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/asm-scal.dir/main.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/alex/vms/YaRPO/Assembler/share/asm-scal/main.c -o CMakeFiles/asm-scal.dir/main.c.s

CMakeFiles/asm-scal.dir/main.c.o.requires:

.PHONY : CMakeFiles/asm-scal.dir/main.c.o.requires

CMakeFiles/asm-scal.dir/main.c.o.provides: CMakeFiles/asm-scal.dir/main.c.o.requires
	$(MAKE) -f CMakeFiles/asm-scal.dir/build.make CMakeFiles/asm-scal.dir/main.c.o.provides.build
.PHONY : CMakeFiles/asm-scal.dir/main.c.o.provides

CMakeFiles/asm-scal.dir/main.c.o.provides.build: CMakeFiles/asm-scal.dir/main.c.o


# Object files for target asm-scal
asm__scal_OBJECTS = \
"CMakeFiles/asm-scal.dir/main.c.o"

# External object files for target asm-scal
asm__scal_EXTERNAL_OBJECTS =

asm-scal: CMakeFiles/asm-scal.dir/main.c.o
asm-scal: CMakeFiles/asm-scal.dir/build.make
asm-scal: CMakeFiles/asm-scal.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable asm-scal"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/asm-scal.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/asm-scal.dir/build: asm-scal

.PHONY : CMakeFiles/asm-scal.dir/build

CMakeFiles/asm-scal.dir/requires: CMakeFiles/asm-scal.dir/main.c.o.requires

.PHONY : CMakeFiles/asm-scal.dir/requires

CMakeFiles/asm-scal.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/asm-scal.dir/cmake_clean.cmake
.PHONY : CMakeFiles/asm-scal.dir/clean

CMakeFiles/asm-scal.dir/depend:
	cd "/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/vms/YaRPO/Assembler/share/asm-scal /home/alex/vms/YaRPO/Assembler/share/asm-scal "/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию" "/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию" "/home/alex/vms/YaRPO/Assembler/share/build-asm-scal-Desktop_Qt_5_8_0_GCC_64bit-По умолчанию/CMakeFiles/asm-scal.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/asm-scal.dir/depend

