project(libp2p-peer C)
cmake_policy(SET CMP0054 NEW)

include(libp2pdefault)
include(CheckIncludeFile)

check_include_file(time.h HAVE_TIME_H)
if(HAVE_TIME_H)
    add_definitions(-DHAVE_TIME_H=1)
endif()

set(SRC
    peer.c
    peerstore.c
    providerstore.c)

    #include "multiaddr/multiaddr.h"
#include "protobuf.h"
#include "libp2p/net/multistream.h"
#include "libp2p/peer/peer.h"
#include "libp2p/secio/secio.h"
#include "libp2p/utils/linked_list.h"
#include "libp2p/utils/logger.h"
#include "libp2p/yamux/yamux.h"
#include "libp2p/conn/dialer.h"

include_directories(
    ../include
    ${CARRIER_INT_DIST_DIR}/include)

link_directories(
    ${CARRIER_INT_DIST_DIR}/lib)

set(LIBS
    cjson
    libcurl
    crystal
    toxcore
    flatccrt)

if(WIN32)
    set(LIBS
        ${LIBS}
        pthread
        libsodium.lib)
else()
    set(LIBS
        ${LIBS}
        sodium)
endif()

add_definitions(-DCARRIER_BUILD)

add_custom_target(p2p-peer)

if(ENABLE_STATIC)
    add_library(peer-static STATIC ${SRC})

    target_compile_definitions(peer-static PRIVATE CARRIER_STATIC CRYSTAL_STATIC)
    set_target_properties(peer-static PROPERTIES OUTPUT_NAME peer)
    if(WIN32)
        set_target_properties(peer-static PROPERTIES LINK_FLAGS /FORCE:MULTIPLE)
    endif()

    add_dependencies(p2p-peer peer-static)

    install(TARGETS peer-static
        RUNTIME DESTINATION "bin"
        ARCHIVE DESTINATION "lib"
        LIBRARY DESTINATION "lib")
endif()

