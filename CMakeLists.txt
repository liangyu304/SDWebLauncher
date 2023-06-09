cmake_minimum_required(VERSION 3.20)

project(SdWebLauncher VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick Core Qml REQUIRED)
find_package(FramelessHelper REQUIRED COMPONENTS Quick Core)

# 添加目录下的所有cpp .h .qml
file(GLOB_RECURSE ADDITIONAL_SOURCE_FILES
    src/*.cpp
    src/*.h
    src/*.qml
)

# 将源文件和附加文件合并
list(APPEND SOURCE_FILES ${ADDITIONAL_SOURCE_FILES})
set(FRAMELESSHELPER_IMPORT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/qml")
list(APPEND QML_IMPORT_PATH "${FRAMELESSHELPER_IMPORT_DIR}")
list(REMOVE_DUPLICATES QML_IMPORT_PATH)
set(QML_IMPORT_PATH ${QML_IMPORT_PATH} CACHE STRING "Qt Creator extra QML import paths" FORCE)

qt6_add_resources(QT_RESOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/image_resource.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/qml/qml_resource.qrc
)

qt_add_executable(${PROJECT_NAME}
    ${SOURCE_FILES}
    ${QT_RESOURCES}
)

qt_add_qml_module(${PROJECT_NAME}
    URI SdWebLauncher
    VERSION 1.0
    QML_FILES src/qml/main.qml
    ${GLOB_RECURSE}
)

# 设置可执行文件输出路径
# SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../bin)
SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/bin)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
    FramelessHelper::Core
    FramelessHelper::Quick
)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
