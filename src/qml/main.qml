/*
  This file is part of QPrompt Studio.

  SPDX-FileCopyrightText: 2021 Javier O. Cordero Pérez
  Author: Javier O. Cordero Pérez <javiercorderoperez@gmail.com>

  SPDX-License-Identifier: GPL-3.0-only

  Contact Javier Cordero at <javiercorderoperez@gmail.com> for commercial licensing options.
*/


import QtQuick 2.6
import org.kde.kirigami 2.9 as Kirigami
import QtQuick.Controls 2.15
import com.kdab.dockwidgets 1.0 as KDDW
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1 as Labs

import com.cuperino.qprompt.document 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 1366
    height: 728

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")

            Action {
                text: qsTr("Save layout")
                onTriggered: {
                    layoutSaver.saveToFile("mySavedLayout.json");
                }
            }

            Action {
                text: qsTr("Restore layout")
                onTriggered: {
                    layoutSaver.restoreFromFile("mySavedLayout.json");
                }
            }

            Action {
                text: qsTr("Toggle widget #4")
                onTriggered: {
                    toggleDockWidget(dock4);
                }
            }

            Action {
                text: qsTr("Toggle widget #5")
                onTriggered: {
                    toggleDockWidget(dock5);
                }
            }

            Action {
                text: qsTr("Toggle widget #6")
                onTriggered: {
                    toggleDockWidget(dock6);
                }
            }

            Action {
                text: qsTr("Close All")
                onTriggered: {
                   _kddwDockRegistry.clear();
                }
            }

            MenuSeparator { }
            Action { text: qsTr("&Quit")
                onTriggered: {
                    Qt.quit();
                }
            }
        }
    }

    Rectangle {

    KDDW.MainWindowLayout {
        anchors.fill: parent
        color: "steelblue"

        Component.onCompleted: {
        }
    }

    KDDW.LayoutSaver {
        id: layoutSaver
    }

    function toggleDockWidget(dw) {
        if (dw.dockWidget.isOpen()) {
            dw.dockWidget.close();
        } else {
            dw.dockWidget.show();
        }
    }
}
