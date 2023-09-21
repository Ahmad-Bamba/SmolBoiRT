cmake_minimum_required(VERSION 3.12...3.27)
project(SmolBoiRadioTelescope VERSION 1.0 LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

add_subdirectory(gr_programs)
add_subdirectory(gr_modules)
add_subdirectory(backend)
