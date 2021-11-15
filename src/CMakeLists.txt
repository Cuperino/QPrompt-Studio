set(qpromptstudio_SRCS
    main.cpp
    QPrompt/src/prompter/documenthandler.cpp
    QPrompt/src/prompter/markersmodel.cpp
    #QPrompt/src/prompter/timer/promptertimer.cpp
)

set(qpromptstudio_HDRS
    QPrompt/src/prompter/documenthandler.h
    QPrompt/src/prompter/markersmodel.h
    #QPrompt/src/prompter/timer/promptertimer.h
)

set(qpromptstudio_ASSETS
    QPrompt/src/assets.qrc
)

#if (Qt5QuickCompiler_FOUND)
    #qtquick_compiler_add_resources(qpromptstudio_SRCS resources.qrc)
#else ()
    qt5_add_resources(qpromptstudio_SRCS resources.qrc)
#endif()

add_executable(qpromptstudio ${qpromptstudio_SRCS} ${qpromptstudio_HDRS} ${qpromptstudio_ASSETS})
#add_executable(qpromptstudio main.cpp ${qpromptstudio_SRCS})

target_link_libraries(qpromptstudio
    Qt5::Core
    Qt5::Quick
    Qt5::Gui
    Qt5::Svg
    Qt5::Qml
    Qt5::QuickControls2
    Qt5::Network
    Qt5::Widgets
    KDAB::kddockwidgets
    KF5::Kirigami2
    KF5::I18n
)
