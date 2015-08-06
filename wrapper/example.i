%module example
%{
/* Includes the header in the wrapper code */
#include "../pointmatcher/PointMatcher.h"
#include "../pointmatcher/PointMatcherPrivate.h"
#include "../pointmatcher/Parametrizable.h"
#include "../pointmatcher/Registrar.h"
#include "../pointmatcher/Timer.h"
#include "../pointmatcher/IO.h"
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

// token definitions required by the classes below
#define NABO_VERSION_INT 10006 // last tested version

// include wrapped classes (note: order matters)
%include "std_string.i"
%include "../pointmatcher/Registrar.h"
%include "../pointmatcher/Parametrizable.h"
%include "../pointmatcher/PointMatcher.h"
%include "../pointmatcher/PointMatcherPrivate.h"
%include "../pointmatcher/Timer.h"
%include "../pointmatcher/IO.h"
