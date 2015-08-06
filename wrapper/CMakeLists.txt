# wrapper details
set(WRAP_CSHARP "false" CACHE BOOL "Set to ON if the C# wrapper file should be compiled. The wrapper file must be generated externally with SWIG.")
set(WRAP_CSHARP_FILE "example_wrap.cxx" CACHE FILEPATH "Path to the C# wrapper file (.cxx extension)")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MT")

# create wrapper library
add_library(example SHARED ${WRAP_CSHARP_FILE})
target_link_libraries(example pointmatcher)
install(TARGETS example
		ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
		LIBRARY DESTINATION ${INSTALL_LIB_DIR}
		RUNTIME DESTINATION ${INSTALL_BIN_DIR})
