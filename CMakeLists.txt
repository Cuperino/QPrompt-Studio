cmake_minimum_required(VERSION 3.16)

set(RELEASE_SERVICE_VERSION_MAJOR "0")
set(RELEASE_SERVICE_VERSION_MINOR "1")
set(RELEASE_SERVICE_VERSION_MICRO "0")
set(RELEASE_SERVICE_VERSION "${RELEASE_SERVICE_VERSION_MAJOR}.${RELEASE_SERVICE_VERSION_MINOR}.${RELEASE_SERVICE_VERSION_MICRO}")

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to create code from Qt designer ui files
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
#set(CMAKE_CXX_STANDARD 20)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(QT_MIN_VERSION 6.3.0)
set(ECM_MIN_VERSION 5.83.0)
set(KF_MIN_VERSION 5.68.0)

project(qprompt
    VERSION ${RELEASE_SERVICE_VERSION}
    DESCRIPTION "Teleprompter software for teleprompter operators"
    HOMEPAGE_URL "https://qprompt.app/studio"
    LANGUAGES CXX
)

# Send compiled program and library binaries to "build/bin"
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

find_package(ECM ${ECM_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
find_package(Qt6 ${QT_MIN_VERSION} REQUIRED COMPONENTS
    Core
    Quick
    Gui
    Svg
    Qml
    QuickControls2
    Network
    Widgets
    #QuickCompiler
)
#find_package(KF5 ${KF_MIN_VERSION} REQUIRED COMPONENTS
#    Kirigami2
#    I18n  # NO_MODULE
#)
find_package(ECM ${ECM_MIN_VERSION} REQUIRED NO_MODULE)
find_package(KDDockWidgets-qt6 REQUIRED CONFIG)

if (WIN32 OR UNIX) # AND NOT ANDROID
    include(KDEInstallDirs)
    include(KDECMakeSettings)
    include(ECMInstallIcons)
    include(ECMAddAppIcon)
endif()
include(KDECompilerSettings NO_POLICY_SCOPE)
include(KDEClangFormat)
include(ECMQtDeclareLoggingCategory)
include(ECMSetupVersion)
include(ECMSourceVersionControl)
include(FeatureSummary)

# Version management
if (${ECM_SOURCE_UNDER_VERSION_CONTROL})
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # Get the latest abbreviated commit hash of the working branch
    execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    add_definitions(-DGIT_COMMIT_HASH="${GIT_COMMIT_HASH}")
    add_definitions(-DGIT_BRANCH="${GIT_BRANCH}")

else()
    add_definitions(-DGIT_COMMIT_HASH="${RELEASE_SERVICE_VERSION}")
    add_definitions(-DGIT_BRANCH="Stable")
endif()

add_subdirectory(src)

if (WIN32 OR UNIX) # AND NOT ANDROID
    install(FILES com.cuperino.qpromptstudio.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
    install(PROGRAMS com.cuperino.qpromptstudio.desktop DESTINATION ${KDE_INSTALL_APPDIR})
    install(FILES ${DOCS} DESTINATION ${DOC_INSTALL_DIR})
endif()

#ki18n_install(po)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES) # INCLUDE_QUIET_PACKAGES
