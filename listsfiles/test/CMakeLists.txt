set(DIR_SRC ${BOOST_DIR}/libs/test)
file( GLOB test_src ${DIR_SRC}/src/*.cpp ) 
add_library(boost_unit_test_framework ${test_src} )
target_compile_definitions( boost_unit_test_framework PUBLIC ${BOOST_DEF} )
install(TARGETS boost_unit_test_framework DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_unit_test_framework PROPERTIES FOLDER "boost/libs")
