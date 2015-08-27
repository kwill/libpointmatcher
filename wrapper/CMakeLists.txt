# wrapper details
set(WRAP_CSHARP "false" CACHE BOOL "Set to ON if the C# wrapper file should be compiled. The wrapper file must be generated externally with SWIG.")
set(WRAP_CSHARP_FILE "example_wrap.cxx" CACHE FILEPATH "Path to the C# wrapper file (.cxx extension)")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MT")

# create unit test as a library
# include_directories(../contrib/gtest)
# add_library(utest_library
#				../utest/utest.cpp
#                ../utest/ui/IO.cpp 
#                ../utest/ui/DataFilters.cpp 
#                ../utest/ui/Matcher.cpp 
#                ../utest/ui/Outliers.cpp 
#                ../utest/ui/ErrorMinimizers.cpp 
#                ../utest/ui/Transformations.cpp 
#                ../utest/ui/DataPoints.cpp 
#                ../utest/ui/Inspectors.cpp 
#                ../utest/ui/Loggers.cpp)
#target_link_libraries(utest_library gtest pointmatcher)

# create wrapper library
add_library(example SHARED ${WRAP_CSHARP_FILE})
target_link_libraries(example pointmatcher)
# target_link_libraries(example utest_library)
install(TARGETS example
		ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
		LIBRARY DESTINATION ${INSTALL_LIB_DIR}
		RUNTIME DESTINATION ${INSTALL_BIN_DIR})
