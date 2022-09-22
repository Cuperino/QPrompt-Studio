/*
  This file is part of QPrompt Studio.

  SPDX-FileCopyrightText: 2022 Javier O. Cordero Pérez
  Author: Javier O. Cordero Pérez <javiercorderoperez@gmail.com>

  SPDX-License-Identifier: GPL-3.0-only

  Contact Javier Cordero at <javiercorderoperez@gmail.com> for commercial licensing options.
*/


import QtQuick 2.6
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
//import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1 as Labs

import com.kdab.dockwidgets 2.0 as KDDW
//import org.kde.kirigami 2.9 as Kirigami

//import com.cuperino.qprompt.document 1.0

ApplicationWindow {
    id: root
    readonly property bool __isMobile: false
    property bool __fullScreen: false
    property bool __autoFullScreen: false
    property bool fullScreenPlatform: false
    property bool __translucidBackground: true // !__opacity
    property bool __scrollAsDial: false
    property bool __invertArrowKeys: false
    property bool __invertScrollDirection: false
    property bool __noScroll: false
    property bool __telemetry: true
    property bool forceQtTextRenderer: false
    property bool passiveNotifications: true
    property bool __throttleWheel: true
    property int __wheelThrottleFactor: 8
    //property int prompterVisibility: Kirigami.ApplicationWindow.Maximized
    property real __baseSpeed: 3.0
    property real __curvature: 1.2
    property double __opacity: 1.0
    property int __iDefault: 3
    property int onDiscard: Prompter.CloseActions.Ignore
    property bool ee: false
    property bool theforce: false
    readonly property bool mobileOrSmallScreen: false // root.width < 1220

    function toggleDockWidget(dw) {
        if (dw.dockWidget.isOpen()) {
            dw.dockWidget.close();
        } else {
            dw.dockWidget.show();
        }
    }

    visible: true
    width: 1366
    height: 728
    title: viewport.document.fileName + (viewport.document.modified?"*":"") + " - " + "QPrompt Studio"
    color: "transparent" // root.__translucidBackground ? "transparent" : "initial"

    background: Rectangle {
        color: appTheme.__backgroundColor
        opacity: appTheme.opacity
    }
    Item {
        id: appTheme
        property int selection: 2
        property color __backgroundColor: switch(selection) {
            //case 0: return Qt.rgba(Kirigami.Theme.backgroundColor.r/4, Kirigami.Theme.backgroundColor.g/4, Kirigami.Theme.backgroundColor.b/4, 1);
            case 1: return "#303030";
            case 2: return "#FAFAFA";
        }
        //opacity: (!root.__translucidBackground || viewport.prompterBackground.opacity===1) ? 1.0 : 0.0
    }

    Labs.MenuBar {
        id: nativeMenus
        //window: root
        menus: [
        Labs.Menu {
            title: qsTr("&File")

            Labs.MenuItem {
                text: qsTr("Save layout")
                onTriggered: {
                    layoutSaver.saveToFile("mySavedLayout.json");
                }
            }

            Labs.MenuItem {
                text: qsTr("Restore layout")
                onTriggered: {
                    layoutSaver.restoreFromFile("mySavedLayout.json");
                }
            }

            Labs.MenuItem {
                text: qsTr("Toggle widget #4")
                onTriggered: {
                    toggleDockWidget(dock4);
                }
            }

            Labs.MenuItem {
                text: qsTr("Toggle widget #5")
                onTriggered: {
                    toggleDockWidget(dock5);
                }
            }

            Labs.MenuItem {
                text: qsTr("Toggle widget #6")
                onTriggered: {
                    toggleDockWidget(dock6);
                }
            }

            Labs.MenuItem {
                text: qsTr("Close All")
                onTriggered: {
                   _kddwDockRegistry.clear();
                }
            }

            Labs.MenuSeparator { }
            Labs.MenuItem {
                text: qsTr("&Quit")
                onTriggered: {
                    Qt.quit();
                }
            }
        }
        ]
    }

    Item {
        id: prompterPage
    }

    property int q: 0
    onFrameSwapped: {
        // Thus runs from here because there's no event that occurs on each bit of scroll, and this takes much less CPU than a timer, is more precise and scales better.
        viewport.prompter.markerCompare()
        // Update Projections
        if (projectionManager.isEnabled && root.visible/* && projectionManager.model.count*/)
            // Recount projections on each for loop iteration to prevent value from going stale because a window was closed from a different thread.
            for (var i=0; i<projectionManager.projections.count; i++) {
                const w = projectionManager.projections.objectAt(i)
                if (w/*!==null*/)
                    w.update();
                else
                    break;
            }
    }

    ProjectionsManager {
        id: projectionManager
        backgroundColor: "#000000"//root.pageStack.currentItem.prompterBackground.color
        backgroundOpacity: viewport.prompterBackground.opacity
        //Forward to prompter and not editor to prevent editing from projection windows
        //forwardTo: root.pageStack.currentItem.prompter
        forwardTo: prompterPage
    }

    property alias viewport: prompterPage1.viewport
    property alias editorToolbar: editorToolbar1
    property alias sideDrawer: sideDrawer1

    KDDW.DockingArea {
        id: layout

        anchors.fill: parent

        // Equivalent to initializing MainWindow with HasCentralFrame from constructor.
        //options: KDDW.KDDockWidgets.MainWindowOption_HasCentralFrame

        // property alias prompter: viewport.prompter
        //property alias editor: viewport.editor
        //property alias overlay: viewport.overlay
        //property alias document: viewport.document
        //property alias prompterBackground: viewport.prompterBackground

        // Each main layout needs a unique id
        uniqueName: "MainLayout-1"

        //Repeater {
        //    model: 3
        //    KDDW.DockWidget {
        //        uniqueName: "fromRepeater-" + index
        //        source: ":/Another.qml"
        //    }
        //}

        KDDW.DockWidget {
            id: prompterDock
            uniqueName: "Editor"
            property alias prompterPage: prompterPage1
            PrompterPage {
                id: prompterPage1
                editorToolbar: editorToolbarDock.toolbar
//                 anchors.fill: parent
//                 clip: true
            }
        }

        KDDW.DockWidget {
            id: markersDock
            uniqueName: "Markers"
            property alias sideDrawer: sideDrawer1
            //MarkersDrawer {
            //    id: sideDrawer
            //}
            Rectangle {
                id: sideDrawer1
                color: "#00FF00"
                anchors.fill: parent
            }
        }
        KDDW.DockWidget {
            id: projectionsDock
            uniqueName: "Screens"
            Rectangle {
                color: "#FF00FF"
                anchors.fill: parent
            }
        }
        KDDW.DockWidget {
            id: editorToolbarDock
            property alias toolbar: editorToolbar1
            uniqueName: "Toolbar"
            EditorToolbar {
                id: editorToolbar1
                anchors.fill: parent
            }
            //Rectangle {
            //    id: editorToolbar1
            //    color: "#0000FF"
            //    anchors.fill: parent
            //}
        }
/*
        KDDW.DockWidget {
            id: test
            uniqueName: "Test"
            source: ":/Test.qml"
        }*/

        Component.onCompleted: {
            //projectionManager.putDisplayFlip(Qt.application.screens[0].name, 1/*flipSetting*/)

            addDockWidget(prompterDock, KDDW.KDDockWidgets.Location_OnRight, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);
            addDockWidget(markersDock, KDDW.KDDockWidgets.Location_OnLeft, prompterPage, Qt.size(320, 100));
            addDockWidget(editorToolbarDock, KDDW.KDDockWidgets.Location_OnBottom, null, Qt.size(1920, 24), KDDW.KDDockWidgets.Option_NotClosable);
            markersDock.addDockWidgetAsTab(projectionsDock);
            //addDockWidget(test, KDDW.KDDockWidgets.Location_OnBottom, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);
            //addDockWidgetAsTab(test);
            //addDockWidget(prompterPage, KDDW.KDDockWidgets.Location_OnTop, null, Qt.size(800, 600), KDDW.KDDockWidgets.Option_NotClosable);

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
}
