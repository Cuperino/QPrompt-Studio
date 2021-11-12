qt5_add_resources(qpromptstudio_SRCS resources.qrc)
add_executable(qpromptstudio main.cpp ${qpromptstudio_SRCS})
target_link_libraries(qpromptstudio Qt5::Qml Qt5::Gui)

