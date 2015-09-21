%module libpm
%{
/* Includes the headers in the wrapper code (note: order matters) */
#include "pointmatcher\IO.h"
#include "pointmatcher\Timer.h"
#include "pointmatcher\PointMatcherPrivate.h"
#include "pointmatcher\PointMatcher.h"
#include "pointmatcher\Parametrizable.h"
#include "pointmatcher\Registrar.h"
%}

/* Gracefully handle all exceptions */
// from http://swig.org/Doc3.0/SWIGDocumentation.html#Library_stl_exceptions

%include "exception.i"

%exception {
  try {
    $action
  } catch (const std::exception& e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
}

/* Standard wrappers for other exceptions, strings and arrays */

%include "std_except.i"
%include "std_string.i"

%include "carrays.i"
%array_class(float, floatArray);

/* C# wrappers for array parameters */

%include "arrays_csharp.i"
%apply float INPUT[]  {float* array_in}
%apply float OUTPUT[] {float* array_out}
// wraps arrays used in helper functions mapArrayToMatrix and mapMatrixToArray
// (note that array_out seems unreliable and iteration over a floatArray is preferred;
// array_in works as expected)
// see also http://stackoverflow.com/questions/5822529/swig-returning-an-array-of-doubles

/* Prerequisite headers - SWIG definitions */

%rename(process) operator ();
%rename(shiftLeft) operator <<;
%rename(shiftRight) operator >>;
%rename(isEqual) operator ==;
// name C++-only operators

%ignore loggerMutex;
// SWIG .cxx compilation fails for this object
// (occurs when using underlying Boost library)

%ignore getNameParamsFromYAML;
// MSVC compilation of .cxx fails for this method
// (because the .cxx uses Parametrizable::Parameters instead of
// PointMatcherSupport::Parametrizable::Parameters)

/* Prerequisite headers - include header files */

#define NABO_VERSION "1.0.6"
#define NABO_VERSION_INT 10006
// last tested version (token definition required in headers below)

%include "../pointmatcher/Registrar.h"
%include "../pointmatcher/Parametrizable.h"
// parse the prerequisite header files

/* Primary API - SWIG definitions */

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

/* Primary API - header file */

#define WRAPPER_VERSION "0.3.0"
#define WRAPPER_VERSION_INT 00300
// version number for this interface file

%include "../pointmatcher/PointMatcher.h"
// parse the primary API

%template(PM) PointMatcher<float>;
// create a concrete class from the PointMatcher<T> template
