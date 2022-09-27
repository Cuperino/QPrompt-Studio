//  This file is part of QPrompt Studio.
// SPDX-FileCopyrightText: 2022 Javier O. Cordero Pérez
// SPDX-License-Identifier: GPL-3.0-only


import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#1A1A1A" //"#eff0f1"

    readonly property QtObject separator: parent

    MouseArea {
        cursorShape: separator ? (separator.isVertical ? Qt.SizeVerCursor : Qt.SizeHorCursor)
                                   : Qt.SizeHorCursor
        anchors.fill: parent
        onPressed: {
            separator.onMousePressed();
        }

        onReleased: {
            separator.onMouseReleased();
        }

        onPositionChanged: (mouse) => {
            separator.onMouseMoved(Qt.point(mouse.x, mouse.y));
        }

        onDoubleClicked: {
            separator.onMouseDoubleClicked();
        }
    }
}
