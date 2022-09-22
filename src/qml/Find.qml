/*
  This file is part of QPrompt Studio.

  SPDX-FileCopyrightText: 2021-2022 Javier O. Cordero Pérez <javiercorderoperez@gmail.com>
  Author: Javier O. Cordero Pérez <javiercorderoperez@gmail.com>

  SPDX-License-Identifier: GPL-3.0-only
*/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import com.cuperino.qprompt.abstractunits 1.0

Item {
    enum Mode {
        Match,
        Previous,
        Next
    }
    property var document
    property bool isOpen: false
    property bool resultsFound: false
    readonly property int searchBarWidth: 660
    readonly property int searchBarMargin: 6
    function focusSearch() {
        if (isOpen) {
            searchField.text = editor.selectedText
            searchField.focus = true
        }
        else {
            // Clear search
            editor.cursorPosition = document.selectionStart
                editor.focus = true
        }
    }
    function toggle() {
        isOpen = !visible
        focusSearch()
    }
    function open() {
        isOpen = true
        focusSearch()
    }
    function close() {
        isOpen = false
        focusSearch()
    }
    anchors.leftMargin: viewport.width<608 ? 4 : searchBarMargin
    anchors.rightMargin: viewport.width<608 ? 32 : (viewport.width < searchBarWidth ? searchBarMargin : viewport.width - searchBarWidth + searchBarMargin)
    anchors.left: parent.left
    anchors.right: parent.right
    // I am aware that manipulating Y is slower to process, but dynamically switching between top and bottom anchoring is not an option because it overrides height.
    height: isOpen && parseInt(prompter.state)!==Prompter.States.Prompting && parseInt(prompter.state)!==Prompter.States.Countdown ? find.implicitHeight : 0
    y: overlay.__readRegionPlacement > 0.5 ? 0-find.implicitHeight+height : parent.height-height
    visible: height>0
    enabled: visible
    Rectangle {
        id: background
        anchors.left: find.left
        anchors.right: find.right
        anchors.leftMargin: -8
        anchors.rightMargin: -12
        height: overlay.__readRegionPlacement > 0.5 ? find.height : find.height+this.radius
        radius: 4
        opacity: 0.96
        //color: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 1)
        border.width: 1
        border.color: "#606060"
        MouseArea {
            anchors.fill: parent
            onClicked: {}
        }
    }
    Behavior on height {
        enabled: true
        animation: NumberAnimation {
            duration: Units.ShortDuration
            easing.type: Easing.OutQuad
        }
    }
    RowLayout {
        id: find
        function next() {
            find.search(searchField.text, Find.Mode.Next)
        }
        function previous() {
            find.search(searchField.text, Find.Mode.Previous)
        }
        function search(text, mode) {
            var range
            switch (mode) {
                case Find.Mode.Match:
                    range = document.search(text); break;
                case Find.Mode.Previous:
                    range = document.search(text, false, true); break;
                case Find.Mode.Next:
                    range = document.search(text, true); break;
            }
            if (range.y > range.x) {
                editor.select(range.x, range.y)
                resultsFound=true
            }
            else {
                editor.cursorPosition = range.x
                resultsFound=false
            }
            if (text.length>0) {
                const newPosition = editor.cursorRectangle.y - (overlay.__readRegionPlacement*(overlay.height-overlay.readRegionHeight)+overlay.readRegionHeight/2) + 1;
                if (mode===Find.Mode.Next && newPosition<prompter.position)
                    showPassiveNotification(i18n("End reached, searching from the start."))
                else if (mode===Find.Mode.Previous && newPosition>prompter.position)
                    showPassiveNotification(i18n("Start reached, searching from the end."))
                prompter.position = newPosition;
            }
            else
                resultsFound=false
        }
        anchors.fill: parent
        spacing: 6
        Button {
            text: "\u24CD"
            flat: true
            onClicked: close()
            Layout.fillHeight: true
        }
        TextInput {
            id: searchField
            //placeholderText: ""
            wrapMode: TextInput.WordWrap
            onTextEdited: find.search(text, Find.Mode.Match)
            selectByMouse: true
            Layout.fillWidth: true
            Keys.onReturnPressed: {
                if (event.modifiers & Qt.ShiftModifier)
                    return find.previous()
                return find.next()
            }
            Keys.onEscapePressed: close()
        }
        Button {
            text: "\u25B2"
            enabled: resultsFound
            flat: true
            onClicked: find.previous()
        }
        Button {
            text: "\u25BC"
            enabled: resultsFound
            flat: true
            onClicked: find.next()
        }
    }
}
