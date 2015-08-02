%module example
%{
/* Includes the header in the wrapper code */
#include "../pointmatcher/PointMatcher.h"
%}

/*
Gracefully handle all exceptions
(See http://swig.org/Doc3.0/SWIGDocumentation.html#Library_stl_exceptions )
*/

%include "exception.i"

%exception {
  try {
    $action
  } catch (const std::exception& e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
}

/* Parse the header file to generate wrappers */

// ignore these tokens in class definitions below
#define DEF_REGISTRAR(...)
#define DEF_REGISTRAR_IFACE(...)
#define NABO_VERSION_INT 10006 // last tested version

// import referenced classes (will not be wrapped)
%import "../pointmatcher/Parametrizable.h"

// include wrapped classes
%include "std_string.i"
%include "../pointmatcher/PointMatcher.h"
