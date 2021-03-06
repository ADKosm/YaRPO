cmake_minimum_required(VERSION 2.8)
project(share)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/lib")

set(CMAKE_VERBOSE_MAKEFILE on)

find_package(Qt5 5.2.1 COMPONENTS Core Widgets REQUIRED)
include_directories(${Qt5Core_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

find_package(PythonLibs 3.4 REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})

set(CMAKE_CXX_FLAGS "-std=c++11 -fPIC")
set(CMAKE_C_FLAGS "-std=c99 -fPIC")

set(SRC_LIST src/widgets.cpp)

set(HEADERS src/widgets.h)

qt5_wrap_cpp(MOC_SOURCES ${HEADERS})

add_executable(TEST_1 src/test1.c ${SRC_LIST} ${MOC_SOURCES})
add_executable(TEST_2 src/test2.c ${SRC_LIST} ${MOC_SOURCES})
add_library(pywidgets SHARED src/pywidgets.c ${SRC_LIST} ${MOC_SOURCES})
#add_library(testwid SHARED ${SRC_LIST} ${MOC_SOURCES})

target_link_libraries(TEST_1 ${Qt5Core_LIBRARIES} ${Qt5Widgets_LIBRARIES} ${PYTHON_LIBRARIES})
target_link_libraries(TEST_2 ${Qt5Core_LIBRARIES} ${Qt5Widgets_LIBRARIES} ${PYTHON_LIBRARIES})
target_link_libraries(pywidgets ${Qt5Core_LIBRARIES} ${Qt5Widgets_LIBRARIES} ${PYTHON_LIBRARIES})
#target_link_libraries(testwid ${Qt5Core_LIBRARIES} ${Qt5Widgets_LIBRARIES} ${PYTHON_LIBRARIES})

#set(CMAKE_CXX_STANDARD 11)
#
#set(SOURCE_FILES main.cpp widgets.cpp widgets.h)
#add_executable(share ${SOURCE_FILES})
