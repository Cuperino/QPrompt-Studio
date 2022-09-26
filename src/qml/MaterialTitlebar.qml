// This file is part of QPrompt Studio.
// SPDX-FileCopyrightText: 2022 Javier O. Cordero Pérez
// SPDX-License-Identifier: GPL-3.0-only


import QtQuick 2.6

// Will be moved to a plugin in the future, if there's enough demand
import "qrc:/kddockwidgets/qtquick/views/qml/" as KDDW

KDDW.TitleBarBase {
    id: root

    readonly property int margins: 10

    color: "#303030"
    //border.color: "white"
    //border.width: 2
    //heightWhenVisible: 50

    Text {
        color: "white"
        //font.bold: true
        text: root.title
        anchors {
            left: parent.left
            leftMargin: root.margins
            verticalCenter: root.verticalCenter
        }
    }
/*
    Rectangle {
        id: closeButton
        enabled: root.closeButtonEnabled
        radius: 5
        color: "green"
        height: root.height - 20
        width: height
        anchors {
            right: root.right
            rightMargin: 10
            verticalCenter: root.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.closeButtonClicked();
            }
        }
    }
*/
    Rectangle {
        id: floatButton
        enabled: root.floatButtonVisible
        radius: 3
        color: "#56b57e"
        height: root.height - 20
        width: height
        anchors {
            right: root.right
            rightMargin: root.margins
            verticalCenter: root.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.floatButtonClicked();
            }
        }
    }
}
