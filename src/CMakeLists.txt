set(qpromptstudio_SRCS
    main.cpp
    dockwidgets/materialseparator_qtquick.cpp
    QPrompt/src/prompter/documenthandler.cpp
    QPrompt/src/prompter/markersmodel.cpp
    #QPrompt/src/prompter/timer/promptertimer.cpp
)

set(qpromptstudio_HDRS
    utils/abstractunits.hpp
    dockwidgets/materialseparator_qtquick.h
    QPrompt/src/prompter/documenthandler.h
    QPrompt/src/prompter/marker.hpp
    QPrompt/src/prompter/markersmodel.h
    #QPrompt/src/prompter/timer/promptertimer.h
)

set(qpromptstudio_ASSETS
    assets.qrc
    QPrompt/src/icons/icons.qrc
)

#if (Qt6QuickCompiler_FOUND)
    #qtquick_compiler_add_resources(qpromptstudio_SRCS resources.qrc)
#else ()
    qt_add_resources(qpromptstudio_SRCS resources.qrc)
#endif()

add_executable(qpromptstudio ${qpromptstudio_SRCS} ${qpromptstudio_HDRS} ${qpromptstudio_ASSETS})

target_link_libraries(qpromptstudio
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Svg
    Qt6::Qml
    Qt6::QuickControls2
    #Qt6::Network
    Qt6::Widgets
    KDAB::kddockwidgets
    KF5::I18n
)

# Include KI18N translations
FIND_PROGRAM(GETTEXT_MSGFMT_EXECUTABLE msgfmt)
IF(NOT GETTEXT_MSGFMT_EXECUTABLE)
   MESSAGE(
"------
                NOTE: msgfmt not found. Translations will *not* be installed
------")
ELSE(NOT GETTEXT_MSGFMT_EXECUTABLE)

   SET(catalogname qprompt)

   FILE(GLOB PO_FILES src/QPrompt/po/*.po)
   SET(GMO_FILES)

   FOREACH(_poFile ${PO_FILES})
       GET_FILENAME_COMPONENT(_poFileName ${_poFile} NAME)
       STRING(REGEX REPLACE "^${catalogname}_?" "" _langCode ${_poFileName} )
       STRING(REGEX REPLACE "\\.po$" "" _langCode ${_langCode} )

       IF( _langCode )
           GET_FILENAME_COMPONENT(_lang ${_poFile} NAME_WE)
           SET(_gmoFile ${CMAKE_CURRENT_BINARY_DIR}/${_lang}.gmo)

           ADD_CUSTOM_COMMAND(TARGET ${PROJECT_NAME} # ${_gmoFile}
               COMMAND ${GETTEXT_MSGFMT_EXECUTABLE} --check -o ${_gmoFile} ${_poFile}
               DEPENDS ${_poFile})
           INSTALL(FILES ${_gmoFile} DESTINATION ${LOCALE_INSTALL_DIR}/${_langCode}/LC_MESSAGES/ RENAME ${catalogname}.mo)
           LIST(APPEND GMO_FILES ${_gmoFile})
       ENDIF( _langCode )

   ENDFOREACH(_poFile ${PO_FILES})

   #ADD_CUSTOM_TARGET(translations ALL DEPENDS ${GMO_FILES})

ENDIF(NOT GETTEXT_MSGFMT_EXECUTABLE)
