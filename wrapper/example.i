%module example
%{
/* Includes the headers in the wrapper code (note: order matters) */
#include "pointmatcher\IO.h"
#include "pointmatcher\Timer.h"
#include "pointmatcher\PointMatcherPrivate.h"
#include "pointmatcher\PointMatcher.h"
#include "pointmatcher\Parametrizable.h"
#include "pointmatcher\Registrar.h"
#include "utest\utest.h"
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

/* Standard wrappers for other exceptions and strings */

%include "std_except.i"
%include "std_string.i"

/* Prerequisites */

#define NABO_VERSION_INT 10006
// last tested version (token definition required in headers below)

%rename(instantiate) operator ();
%rename(shift_left) operator <<;
%rename(shift_right) operator >>;
%rename(is_equal) operator ==;
// name C++ operators

%ignore loggerMutex;
// SWIG .cxx compilation fails for this object
// (occurs when using underlying Boost library)

%include "../pointmatcher/Registrar.h"
%include "../pointmatcher/Parametrizable.h"

/* Primary API */

%ignore getFeatureViewByName;
%ignore getFeatureRowViewByName;
%ignore getDescriptorViewByName;
%ignore getDescriptorRowViewByName;
// SWIG .cxx compilation fails for these methods
// (occurs when instantiating Eigen:Block with PointMatcher<float>)

%ignore getLimitNames;
%ignore getConditionVariableNames;
// SWIG .cxx compilation fails for these methods
// (occurs when instantiating PointMatcher<float>::TransformationChecker::
// StringVector)

%include "../pointmatcher/PointMatcher.h"

%template(PointMatcherFloat) PointMatcher<float>;

// %include "../pointmatcher/PointMatcherPrivate.h"
// %include "../pointmatcher/Timer.h"
// %include "../pointmatcher/IO.h"

/* Include a high-level wrapper method (unit_test) for the unit tests */

// %rename(unit_test) main;
// %ignore IcpHelper;
// %include "../utest/utest.h"
