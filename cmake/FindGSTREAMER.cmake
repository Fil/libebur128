include(LibFindMacros)
libfind_package(GSTREAMER GLIB)
libfind_package(GSTREAMER LibXml2)

find_package(PkgConfig)
pkg_check_modules(PC_GSTREAMER QUIET gstreamer-0.10)

set(GSTREAMER_CFLAGS)
foreach(arg ${PC_GSTREAMER_CFLAGS})
    if (NOT "${arg}" MATCHES "-I.*")
        set(GSTREAMER_CFLAGS "${GSTREAMER_CFLAGS} ${arg}")
    endif()
endforeach()

find_path(GSTREAMER_INCLUDE_DIR NAMES gst/gst.h
          HINTS ${PC_GSTREAMER_INCLUDEDIR} ${PC_GSTREAMER_INCLUDE_DIRS}
          PATH_SUFFIXES gstreamer-0.10)

find_library(GSTREAMER_LIBRARY NAMES gstreamer-0.10
             HINTS ${PC_GSTREAMER_LIBDIR} ${PC_GSTREAMER_LIBRARY_DIRS})

find_library(GSTAPP_LIBRARY NAMES gstapp-0.10
             HINTS ${PC_GSTREAMER_LIBDIR} ${PC_GSTREAMER_LIBRARY_DIRS})

find_library(GSTBASE_LIBRARY NAMES gstbase-0.10
             HINTS ${PC_GSTREAMER_LIBDIR} ${PC_GSTREAMER_LIBRARY_DIRS})

find_library(GSTAUDIO_LIBRARY NAMES gstaudio-0.10
             HINTS ${PC_GSTREAMER_LIBDIR} ${PC_GSTREAMER_LIBRARY_DIRS})

set(GSTREAMER_LIBRARIES ${GSTREAMER_LIBRARY} ${GSTAPP_LIBRARY} ${GSTBASE_LIBRARY} ${GSTAUDIO_LIBRARY} ${GLIB_LIBRARIES} ${LIBXML2_LIBRARIES})
set(GSTREAMER_INCLUDE_DIRS ${GSTREAMER_INCLUDE_DIR} ${GLIB_INCLUDE_DIRS} ${LIBXML2_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GSTREAMER DEFAULT_MSG GSTREAMER_INCLUDE_DIR GSTREAMER_LIBRARY GSTAPP_LIBRARY GSTBASE_LIBRARY GSTAUDIO_LIBRARY)
mark_as_advanced(GSTREAMER_INCLUDE_DIR GSTREAMER_LIBRARY GSTAPP_LIBRARY GSTBASE_LIBRARY GSTAUDIO_LIBRARY)
