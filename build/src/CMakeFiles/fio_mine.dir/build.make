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
include src/CMakeFiles/fio_mine.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/fio_mine.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/fio_mine.dir/flags.make

src/CMakeFiles/fio_mine.dir/fio_test.cpp.o: src/CMakeFiles/fio_mine.dir/flags.make
src/CMakeFiles/fio_mine.dir/fio_test.cpp.o: ../src/fio_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/data/experiment_space/fio_mine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/CMakeFiles/fio_mine.dir/fio_test.cpp.o"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/fio_mine.dir/fio_test.cpp.o -c /data/experiment_space/fio_mine/src/fio_test.cpp

src/CMakeFiles/fio_mine.dir/fio_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/fio_mine.dir/fio_test.cpp.i"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /data/experiment_space/fio_mine/src/fio_test.cpp > CMakeFiles/fio_mine.dir/fio_test.cpp.i

src/CMakeFiles/fio_mine.dir/fio_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/fio_mine.dir/fio_test.cpp.s"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /data/experiment_space/fio_mine/src/fio_test.cpp -o CMakeFiles/fio_mine.dir/fio_test.cpp.s

src/CMakeFiles/fio_mine.dir/logger.cpp.o: src/CMakeFiles/fio_mine.dir/flags.make
src/CMakeFiles/fio_mine.dir/logger.cpp.o: ../src/logger.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/data/experiment_space/fio_mine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/CMakeFiles/fio_mine.dir/logger.cpp.o"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/fio_mine.dir/logger.cpp.o -c /data/experiment_space/fio_mine/src/logger.cpp

src/CMakeFiles/fio_mine.dir/logger.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/fio_mine.dir/logger.cpp.i"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /data/experiment_space/fio_mine/src/logger.cpp > CMakeFiles/fio_mine.dir/logger.cpp.i

src/CMakeFiles/fio_mine.dir/logger.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/fio_mine.dir/logger.cpp.s"
	cd /data/experiment_space/fio_mine/build/src && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /data/experiment_space/fio_mine/src/logger.cpp -o CMakeFiles/fio_mine.dir/logger.cpp.s

# Object files for target fio_mine
fio_mine_OBJECTS = \
"CMakeFiles/fio_mine.dir/fio_test.cpp.o" \
"CMakeFiles/fio_mine.dir/logger.cpp.o"

# External object files for target fio_mine
fio_mine_EXTERNAL_OBJECTS =

../lib/libfio_mine.a: src/CMakeFiles/fio_mine.dir/fio_test.cpp.o
../lib/libfio_mine.a: src/CMakeFiles/fio_mine.dir/logger.cpp.o
../lib/libfio_mine.a: src/CMakeFiles/fio_mine.dir/build.make
../lib/libfio_mine.a: src/CMakeFiles/fio_mine.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/data/experiment_space/fio_mine/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX static library ../../lib/libfio_mine.a"
	cd /data/experiment_space/fio_mine/build/src && $(CMAKE_COMMAND) -P CMakeFiles/fio_mine.dir/cmake_clean_target.cmake
	cd /data/experiment_space/fio_mine/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fio_mine.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/fio_mine.dir/build: ../lib/libfio_mine.a

.PHONY : src/CMakeFiles/fio_mine.dir/build

src/CMakeFiles/fio_mine.dir/clean:
	cd /data/experiment_space/fio_mine/build/src && $(CMAKE_COMMAND) -P CMakeFiles/fio_mine.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/fio_mine.dir/clean

src/CMakeFiles/fio_mine.dir/depend:
	cd /data/experiment_space/fio_mine/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /data/experiment_space/fio_mine /data/experiment_space/fio_mine/src /data/experiment_space/fio_mine/build /data/experiment_space/fio_mine/build/src /data/experiment_space/fio_mine/build/src/CMakeFiles/fio_mine.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/fio_mine.dir/depend

