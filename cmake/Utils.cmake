# Loads all the CMAKE_X_FLAGS to a single list to it can be passed
# to the command_Wrapper script.
function(load_flags flags)
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        list(APPEND _flags
            _CFLAGS=${CMAKE_C_FLAGS_RELEASE}
            _CXXFLAGS=${CMAKE_CXX_FLAGS_RELEASE}
            _CPPFLAGS=${CMAKE_CPP_FLAGS_RELEASE}
            _LDFLAGS=${CMAKE_LD_FLAGS_RELEASE}
            )
        string(REPLACE "-O3" "-O2" _flags "${_flags}")
    elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
        list(APPEND _flags
            _CFLAGS=${CMAKE_C_FLAGS_DEBUG}
            _CXXFLAGS=${CMAKE_CXX_FLAGS_DEBUG}
            _CPPFLAGS=${CMAKE_CPP_FLAGS_DEBUG}
            _LDFLAGS=${CMAKE_LD_FLAGS_DEBUG}
            )
    else()
        list(APPEND _flags
            _CFLAGS=${CMAKE_C_FLAGS}
            _CXXFLAGS=${CMAKE_CXX_FLAGS}
            _CPPFLAGS=${CMAKE_CPP_FLAGS}
            _LDFLAGS=${CMAKE_LD_FLAGS}
            )
    endif()

    set(${flags} ${_flags} PARENT_SCOPE)
endfunction()

# Finds a gcc library and save the absolute path to varname
function(getgcclib libname varname)
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -print-prog-name=${libname} OUTPUT_VARIABLE filename OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(NOT EXISTS "${filename}")
        execute_process(COMMAND ${CMAKE_CXX_COMPILER} -print-file-name=${libname} OUTPUT_VARIABLE filename OUTPUT_STRIP_TRAILING_WHITESPACE)
    endif()
    if(filename)
        get_filename_component(filename ${filename} ABSOLUTE)
    endif()
    if(EXISTS "${filename}")
        set(${varname} ${filename} PARENT_SCOPE)
    endif()
endfunction()
