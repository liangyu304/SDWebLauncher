cmake_minimum_required(VERSION 3.16)

project(SdWebLauncher VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

# 添加要包含的目录
set(SOURCE_FILES
    src/main.cpp
)

# 添加目录下的所有cpp和.h文件
file(GLOB_RECURSE ADDITIONAL_SOURCE_FILES
    src/*.cpp
    src/*.h
    src/*.qml
)

# 将源文件和附加文件合并
list(APPEND SOURCE_FILES ${ADDITIONAL_SOURCE_FILES})

qt6_add_resources(QT_RESOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/qml/qml_resource.qrc)


qt_add_executable(appSdWebLauncher
    ${SOURCE_FILES}
    ${TaoQuickRes}
    ${QT_RESOURCES}
)

qt_add_qml_module(appSdWebLauncher
    URI SdWebLauncher
    VERSION 1.0
    QML_FILES src/qml/main.qml
)



# TODO(@ly) 后面发包需要用到这个
#if (CMAKE_BUILD_TYPE MATCHES "Release")
#    add_executable(appSdWebLauncher ${TaoQuickRes})
#else()
#    add_executable(appSdWebLauncher ${PROJECT_NAME})
#endif()

set(TAOQUICK_PATH ${CMAKE_CURRENT_SOURCE_DIR}/3trdparty/taoQuick.cmake)
include(${TAOQUICK_PATH})

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3trdparty/FluentUI)

set_target_properties(appSdWebLauncher PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSdWebLauncher
    PRIVATE Qt6::Quick
    fluentuiplugin
    FramelessHelper::Core
    FramelessHelper::Quick
)

install(TARGETS appSdWebLauncher
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
