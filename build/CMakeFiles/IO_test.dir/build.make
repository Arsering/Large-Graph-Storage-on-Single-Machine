# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

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
CMAKE_SOURCE_DIR = /data/experiment_space/fio_mine

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /data/experiment_space/fio_mine/build

# Include any dependencies generated for this target.
include CMakeFiles/IO_test.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/IO_test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/IO_test.dir/flags.make

CMakeFiles/IO_test.dir/main.cpp.o: CMakeFiles/IO_test.dir/flags.make
CMakeFiles/IO_test.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/data/experiment_space/fio_mine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/IO_test.dir/main.cpp.o"
	/usr/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/IO_test.dir/main.cpp.o -c /data/experiment_space/fio_mine/main.cpp

CMakeFiles/IO_test.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/IO_test.dir/main.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /data/experiment_space/fio_mine/main.cpp > CMakeFiles/IO_test.dir/main.cpp.i

CMakeFiles/IO_test.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/IO_test.dir/main.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /data/experiment_space/fio_mine/main.cpp -o CMakeFiles/IO_test.dir/main.cpp.s

# Object files for target IO_test
IO_test_OBJECTS = \
"CMakeFiles/IO_test.dir/main.cpp.o"

# External object files for target IO_test
IO_test_EXTERNAL_OBJECTS =

../bin/IO_test: CMakeFiles/IO_test.dir/main.cpp.o
../bin/IO_test: CMakeFiles/IO_test.dir/build.make
../bin/IO_test: ../lib/libfio_mine.a
../bin/IO_test: CMakeFiles/IO_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/data/experiment_space/fio_mine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/IO_test"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/IO_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/IO_test.dir/build: ../bin/IO_test

.PHONY : CMakeFiles/IO_test.dir/build

CMakeFiles/IO_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/IO_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/IO_test.dir/clean

CMakeFiles/IO_test.dir/depend:
	cd /data/experiment_space/fio_mine/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /data/experiment_space/fio_mine /data/experiment_space/fio_mine /data/experiment_space/fio_mine/build /data/experiment_space/fio_mine/build /data/experiment_space/fio_mine/build/CMakeFiles/IO_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/IO_test.dir/depend

