if(__libp2p_packages_included)
    return()
endif()
set(__libp2p_packages_included)

## Package Outputs Distribution
set(CPACK_PACKAGE_DESCRIPTION "Elastos Carrier Distribution Packages")
set(CPACK_PACKAGE_VERSION_MAJOR ${CARRIER_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${CARRIER_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${CARRIER_VERSION_PATCH})
set(CPACK_GENERATOR "TGZ")

set(CPACK_PACKAGE_VENDOR "todo")
set(CPACK_PACKAGE_CONTACT "todo@trinity-tech.io")

if(UNIX)
    if(APPLE)
        if(IOS)
            set(PACKAGE_TARGET_SYSTEM "ios")
        else()
            set(PACKAGE_TARGET_SYSTEM "darwin")
        endif()
    else()
        if(ANDROID)
            set(PACKAGE_TARGET_SYSTEM "android")
        elseif(RASPBERRYPI)
            set(PACKAGE_TARGET_SYSTEM "rpi")
        else()
            set(PACKAGE_TARGET_SYSTEM "linux")
        endif()
    endif()

    if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
        set(PACKAGE_TARGET_ARCH "arm64")
    else()
        set(PACKAGE_TARGET_ARCH ${CMAKE_SYSTEM_PROCESSOR})
    endif()
elseif(WIN32)
    set(PACKAGE_TARGET_SYSTEM "windows")

    if(${CMAKE_SIZEOF_VOID_P} STREQUAL "8")
        set(PACKAGE_TARGET_ARCH "x86_64")
    else()
        set(PACKAGE_TARGET_ARCH "i386")
    endif()
else()
endif()

string(CONCAT CPACK_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-"
    "${CPACK_PACKAGE_VERSION_MAJOR}."
    "${CPACK_PACKAGE_VERSION_MINOR}."
    "${CPACK_PACKAGE_VERSION_PATCH}-"
    "${PACKAGE_TARGET_SYSTEM}-"
    "${PACKAGE_TARGET_ARCH}-"
    "${CMAKE_BUILD_TYPE}")

## Package Source distribution.
set(CPACK_SOURCE_GENERATOR "TGZ")

string(CONCAT CPACK_SOURCE_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-"
    "${CPACK_PACKAGE_VERSION_MAJOR}."
    "${CPACK_PACKAGE_VERSION_MINOR}."
    "${CPACK_PACKAGE_VERSION_PATCH}")

string(CONCAT CPACK_SOURCE_IGNORE_FILES
    "/build;"
    "/.git;"
    "/docs;"
    "${CPACK_SOURCE_IGNORE_FILES}")

include(CPack)
