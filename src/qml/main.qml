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

    //Item {
        //id: root
    //}
    property bool __scrollAsDial: false
    property bool __invertArrowKeys: false
    property bool __invertScrollDirection: false
    property bool __noScroll: false
    property real __baseSpeed: 3.0
    property real __curvature: 1.2
    property double __opacity: 1.0
    property bool __translucidBackground: false // !__opacity

    KDDW.MainWindowLayout {
        id: prompterPage

        anchors.fill: parent

        // Equivalent to initializing MainWindow with HasCentralFrame from constructor.
        options: KDDW.KDDockWidgets.MainWindowOption_HasCentralFrame

        // property alias prompter: viewport.prompter
        //property alias editor: viewport.editor
        //property alias overlay: viewport.overlay
        //property alias document: viewport.document
        //property alias prompterBackground: viewport.prompterBackground

        // Each main layout needs a unique id
        uniqueName: "MainLayout-1"

//         Repeater {
//             model: 3
//             KDDW.DockWidget {
//                 uniqueName: "fromRepeater-" + index
//                 source: ":/Another.qml"
//             }
//         }

        //KDDW.DockWidget {
            //id: markers
            //uniqueName: "Markers"
            //source: ":/MarkersDrawer.qml"
            //property alias prompterPage: prompterPage
        //}

        //KDDW.DockWidget {
            //id: editorToolbar
            //uniqueName: "Toolbar"
            //source: ":/EditorToolbar.qml"
        //}
/*
        KDDW.DockWidget {
            id: test
            uniqueName: "Test"
            source: ":/Test.qml"
        }*/

        //KDDW.DockWidget {
            //id: viewport
            //uniqueName: "Prompter"
            //source: ":/PrompterView.qml"
            //property alias toolbar: editorToolbar
        //}

        Component.onCompleted: {

            //addDockWidget(markers, KDDW.KDDockWidgets.Location_OnLeft, null, Qt.size(320, 100));
            //addDockWidget(editorToolbar, KDDW.KDDockWicdgets.Location_OnBottom, null, Qt.size(1920, 48), KDDW.KDDockWidgets.Option_NotClosable);
            //addDockWidget(test, KDDW.KDDockWicdgets.Location_OnBottom, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);
            //addDockWidgetAsTab(test);
            //addDockWidget(viewport, KDDW.KDDockWicdgets.Location_OnTop, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);
            //addDockWidget(viewport, null, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);

            // Adds dock6 but specifies a preferred initial size and it starts hidden
            // When toggled it will be shown on the desired dock location.
            // See MainWindowInstantiator_p.h for the API
            //addDockWidget(dock6, KDDW.KDDockWidgets.Location_OnLeft, null,
                                 //Qt.size(500, 100), KDDW.KDDockWidgets.StartHidden);
        }
    }

    KDDW.LayoutSaver {
        id: layoutSaver
    }

    Labs.FontDialog {
        id: fontDialog
        //options: FontDialog.ScalableFonts|FontDialog.MonospacedFonts|FontDialog.ProportionalFonts
        onAccepted: {
            viewport.prompter.document.fontFamily = font.family;
            //viewport.prompter.document.fontSize = font.pointSize*viewport.prompter.editor.font.pixelSize/6;
        }
    }

    Labs.ColorDialog {
        id: colorDialog
        currentColor: "#FFFFFF" // Kirigami.Theme.textColor
    }

    function toggleDockWidget(dw) {
        if (dw.dockWidget.isOpen()) {
            dw.dockWidget.close();
        } else {
            dw.dockWidget.show();
        }
    }
}
