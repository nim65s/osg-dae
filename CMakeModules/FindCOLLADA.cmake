# Locate Collada
# This module defines:
# COLLADA_INCLUDE_DIR, where to find the headers
#
# COLLADA_LIBRARY, COLLADA_LIBRARY_DEBUG
# COLLADA_FOUND, if false, do not try to link to Collada dynamically
#
# COLLADA_LIBRARY_STATIC, COLLADA_LIBRARY_STATIC_DEBUG
# COLLADA_STATIC_FOUND, if false, do not try to link to Collada statically
#
# $COLLADA_DIR is an environment variable that would
# correspond to the ./configure --prefix=$COLLADA_DIR
#
# Created by Robert Osfield. 


# Check if COLLADA_DIR is set, otherwise use ACTUAL_3DPARTY_DIR:
SET( COLLADA_ENV_VAR_AVAILABLE $ENV{COLLADA_DIR} )
IF ( COLLADA_ENV_VAR_AVAILABLE )
    SET(COLLADA_DOM_ROOT "$ENV{COLLADA_DIR}/dom" CACHE PATH "Location of Collada DOM directory" FORCE)
ELSE ( COLLADA_ENV_VAR_AVAILABLE )
    SET(COLLADA_DOM_ROOT "${ACTUAL_3DPARTY_DIR}/include/1.4/dom" CACHE PATH "Location of Collada DOM directory" FORCE)
ENDIF( COLLADA_ENV_VAR_AVAILABLE )



IF(APPLE)
    SET(COLLADA_BUILDNAME "mac")
ELSEIF(MINGW)
    SET(COLLADA_BUILDNAME "mingw")
ELSEIF(MSVC12)
    SET(COLLADA_BUILDNAME "vc12")
ELSEIF(MSVC11)
    SET(COLLADA_BUILDNAME "vc11")
ELSEIF(MSVC10)
    SET(COLLADA_BUILDNAME "vc10")
ELSEIF(MSVC90)
    SET(COLLADA_BUILDNAME "vc9")
ELSEIF(MSVC80)
    SET(COLLADA_BUILDNAME "vc8")
ELSE(APPLE)
  SET(COLLADA_BUILDNAME "linux")
ENDIF(APPLE)


FIND_PATH(COLLADA_INCLUDE_DIR dae.h ${COLLADA14DOM_PREFIX}/include/collada-dom)

FIND_LIBRARY(COLLADA_DYNAMIC_LIBRARY 
    NAMES libcollada14dom.so
    PATHS ${COLLADA14DOM_PREFIX}/lib
)

FIND_LIBRARY(COLLADA_STATIC_LIBRARY 
    NAMES libcollada14dom21-s  libcollada14dom22-s libcollada14dom.a
    PATHS
    ${COLLADA_DOM_ROOT}/build/${COLLADA_BUILDNAME}-1.4
    $ENV{COLLADA_DIR}/build/${COLLADA_BUILDNAME}-1.4
    $ENV{COLLADA_DIR}/lib
    $ENV{COLLADA_DIR}/lib-dbg
    $ENV{COLLADA_DIR}
    ~/Library/Frameworks
    /Library/Frameworks
    /opt/local/Library/Frameworks #macports
    /usr/local/lib
    /usr/local/lib64
    /usr/lib
    /usr/lib64
    /sw/lib
    /opt/local/lib
    /opt/csw/lib
    /opt/lib
    /usr/freeware/lib64
    ${ACTUAL_3DPARTY_DIR}/lib
)



SET(COLLADA_FOUND "NO")
IF(COLLADA_DYNAMIC_LIBRARY OR COLLADA_STATIC_LIBRARY)
    IF   (COLLADA_INCLUDE_DIR)
        SET(COLLADA_FOUND "YES")
    ENDIF(COLLADA_INCLUDE_DIR)
ENDIF(COLLADA_DYNAMIC_LIBRARY OR COLLADA_STATIC_LIBRARY)
