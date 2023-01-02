cmake_minimum_required(VERSION 3.16)

project(AprioritQT_DeskMob_GUI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Widgets)

qt_add_executable(appAprioritQT_DeskMob_GUI
    main.cpp
    imageviewer.cpp
    imageviewer.h
)

qt_add_qml_module(appAprioritQT_DeskMob_GUI
    URI AprioritQT_DeskMob_GUI
    VERSION 1.0
    QML_FILES main.qml 
)

set_target_properties(appAprioritQT_DeskMob_GUI PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAprioritQT_DeskMob_GUI
    PRIVATE Qt6::Quick Qt6::Widgets)

install(TARGETS appAprioritQT_DeskMob_GUI
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
