################################################################################
# FindGNURadio
# ========
# This module finds the GNURadio Companion (GRC) as well gnuradio component
# libraries.
#
# Exports
#   GNURADIO_FOUND if GRC, libraries, and include directory was found
#   GNURADIO_INCLUDE_DIR - gr include directory
#   GNURADIO_LIBRARIES - list of gr library targets
#   GNURADIO_COMPANION_EXE - grc executable
################################################################################

set(_GNU_RADIO_COMPONENTS
    analog
    audio
    blocks
    channels
    digital
    dtv
    fec
    fft
    filter
    iio
    network
    pdu
    pmt
    qtgui
    runtime
    soapy
    trellis
    uhd
    video-sdl
    vocoder
    wavelet
    zeromq
)

# create component library targets
set(GNURADIO_LIBRARIES )
foreach(component IN _GNU_RADIO_COMPONENTS)
    find_library(libgr_${component} NAMES libgnuradio-${component} gnuradio-${component})
    if(NOT libgr_${component} STREQUAL libgr_${component}-NOTFOUND)
        get_filename_component(_libextension ${libgr_${component}} EXT)
        if(${_libextension} MATCHES "so" OR ${_libextension} MATCHES "dll" OR ${_libextension} "dylib")
            add_library(gnuradio::${component} SHARED IMPORTED GLOBAL)
        else()
            add_library(gnuradio::${component} STATIC IMPORTED GLOBAL)
        endif()
        set_target_properties(gnuradio::${component} PROPERTIES IMPORTED_LOCATION ${libgr_${component}})
        list(APPEND GNU_RADIO_LIBRARIES gnuradio::${component})
    endif()
endforeach()
mark_as_advanced(GNURADIO_LIBRARIES)

# include directories
find_path(_block_h_path NAME block.h)
if(NOT ${_block_h_path} STREQUAL _block_h_path-NOTFOUND)
    set(GNURADIO_INCLUDE_DIR ${_block_h_path})
endif()
mark_as_advanced(GNURADIO_INCLUDE_DIR)

# gnradio-companion executable
find_program(_grc NAMES gnuradio-companion)
if (NOT ${_grc} STREQUAL _grc-NOTFOUND)
    set(GNURADIO_COMPANION_EXE ${_grc})
endif()
mark_as_advanced(GNURADIO_COMPANION_EXE)

set(GNURADIO_FOUND )
if(GNURADIO_LIBRARIES AND GNURADIO_INCLUDE_DIR AND GNURADIO_COMPANION_EXE)
    set(GNURADIO_FOUND TRUE)
else()
