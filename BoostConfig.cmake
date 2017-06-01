get_filename_component(Boost_CONFIG_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH CACHE)

if(MSVC)
  if(CMAKE_CL_64)
    set(OpenCV_ARCH x64)
  elseif((CMAKE_GENERATOR MATCHES "ARM") OR ("${arch_hint}" STREQUAL "ARM") OR (CMAKE_VS_EFFECTIVE_PLATFORMS MATCHES "ARM|arm"))
    # see Modules/CmakeGenericSystem.cmake
    set(Boost_ARCH ARM)
  else()
    set(Boost_ARCH x86)
  endif()
  if(MSVC_VERSION EQUAL 1400)
    set(Boost_RUNTIME vc8)
  elseif(MSVC_VERSION EQUAL 1500)
    set(Boost_RUNTIME vc9)
  elseif(MSVC_VERSION EQUAL 1600)
    set(Boost_RUNTIME vc10)
  elseif(MSVC_VERSION EQUAL 1700)
    set(Boost_RUNTIME vc11)
  elseif(MSVC_VERSION EQUAL 1800)
    set(Boost_RUNTIME vc12)
  elseif(MSVC_VERSION EQUAL 1900)
    set(Boost_RUNTIME vc14)
  elseif(MSVC_VERSION EQUAL 1910)
    set(Boost_RUNTIME vc15)
  endif()
elseif(MINGW)
  message(FATAL_ERROR "TODO make CMakelLists.txt linux/apple/... platform")
endif()

set(Boost_INCLUDE_DIRS ${Boost_CONFIG_PATH}/boost_1_64_0 CACHE PATH "Include directories for boost")
set(Boost_LIBRARY_DIRS ${Boost_CONFIG_PATH}/libs/${Boost_ARCH}/${Boost_RUNTIME} CACHE PATH "Library directories for boost")
set(Boost_LIBS_DIR ${Boost_LIBRARY_DIRS})
 
find_package(PythonLibs)
if( PythonLibs_FOUND )
	if(NOT PYTHON_EXECUTABLE)
	  if(NumPy_FIND_QUIETLY)
		find_package(PythonInterp QUIET)
	  else()
		find_package(PythonInterp)
		set(__numpy_out 1)
	  endif()
	endif()
	if (PYTHON_EXECUTABLE)
		execute_process( COMMAND "${PYTHON_EXECUTABLE}" -c
		"from __future__ import print_function\ntry: import numpy; print(numpy.get_include(), end='')\nexcept:pass\n"
		OUTPUT_VARIABLE __numpy_path)	  
		message(__numpy_path=${__numpy_path})
	elseif(__numpy_out)
	  message(STATUS "Python executable not found.")
	endif(PYTHON_EXECUTABLE)
	find_path(PYTHON_NUMPY_INCLUDE_DIR numpy/arrayobject.h HINTS "${__numpy_path}" "${PYTHON_INCLUDE_PATH}" NO_DEFAULT_PATH)
endif()
 
include(${Boost_CONFIG_PATH}/BoostTargets.cmake)
message(STATUS "boost Found in ${boost_LIBRARY_DIRS}")
