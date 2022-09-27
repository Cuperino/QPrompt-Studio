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
    #Qt6::Svg
    Qt6::Qml
    Qt6::QuickControls2
    #Qt6::Network
    Qt6::Widgets
    KDAB::kddockwidgets
)
