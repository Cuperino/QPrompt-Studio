/****************************************************************************
 **
 ** QPrompt Studio
 ** Copyright (C) 2022 Javier O. Cordero Pérez
 **
 ** This file is part of QPrompt Studio.
 **
 ** This program is free software: you can redistribute it and/or modify
 ** it under the terms of the GNU General Public License as published by
 ** the Free Software Foundation, version 3 of the License.
 **
 ** This program is distributed in the hope that it will be useful,
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 **
 ** You should have received a copy of the GNU General Public License
 ** along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **
 ****************************************************************************/

import QtQuick 2.12
//import org.kde.kirigami 2.11 as Kirigami
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1 as Labs

import com.cuperino.qprompt.markers 1.0

Item {
    id: prompterPage

    property alias fontDialog: fontDialog
    property alias colorDialog: colorDialog
    property alias highlightDialog: highlightDialog
    property alias viewport: viewport
    property alias prompter: viewport.prompter
    property alias editor: viewport.editor
    property alias countdown: viewport.countdown
    property alias overlay: viewport.overlay
    property alias document: viewport.document
    property alias openDialog: viewport.openDialog
    property alias prompterBackground: viewport.prompterBackground
    property alias find: viewport.find
//    property alias key_configuration_overlay: key_configuration_overlay
//    property alias displaySettings: displaySettings
//    property alias sideDrawer: sideDrawer
    property var editorToolbar;
    property int hideDecorations: 1

    anchors.fill: parent
    clip: true

//     // Editor Toolbar
//     property var footer: EditorToolbar {
//         id: editorToolbar
//     }

    // Unused signal. Leaving for reference.
    //signal test( bool data )

    Item {
        id: promptingButton // main
//         text: i18n("Start prompter")
//         iconName: Qt.application.layoutDirection === Qt.RightToLeft ? "go-next-rtl" : "go-next"
//         icon.source: Qt.application.layoutDirection === Qt.RightToLeft ? "icons/go-previous.svg" : "icons/go-next.svg"
//         onTriggered: prompter.toggle()
    }
    Item {
        id: decreaseVelocityButton // left
        enabled: false
//         text: pageStack.globalToolBar.actualStyle === Kirigami.ApplicationHeaderStyle.None ? i18n("Decrease velocity") : ""
//         iconName: Qt.application.layoutDirection === Qt.RightToLeft ? "go-previous-rtl" : "go-previous"
//         icon.source: Qt.application.layoutDirection === Qt.RightToLeft ? "icons/go-next.svg" : "icons/go-previous.svg"
        //onTriggered: {
            //if (parseInt(prompter.state) === Prompter.States.Prompting)
                //viewport.prompter.decreaseVelocity(false)
            //else
                //prompter.goToPreviousMarker()
            //viewport.prompter.focus = true;
        //}
    }
    Item {
        id: increaseVelocityButton // right
        enabled: false
        //text: pageStack.globalToolBar.actualStyle === Kirigami.ApplicationHeaderStyle.None ? i18n("Increase velocity") : ""
        //iconName: Qt.application.layoutDirection === Qt.RightToLeft ? "go-next-rtl" : "go-next"
        //icon.source: Qt.application.layoutDirection === Qt.RightToLeft ? "icons/go-previous.svg" : "icons/go-next.svg"
        //onTriggered: {
            //if (parseInt(prompter.state) === Prompter.States.Prompting)
                //viewport.prompter.increaseVelocity(false)
            //else
                //prompter.goToNextMarker()
            //viewport.prompter.restoreFocus()
        //}
    }

    PrompterView {
        id: viewport
        //property alias toolbar: editorToolbar
        height: (forcedOrientation && forcedOrientation!==3 ? parent.width : (root.theforce && !forcedOrientation ? 3 : 1) * parent.height)
        // anchors.bottomMargin: Kirigami.Settings.isMobile ? -68 : 0
        width: (forcedOrientation && forcedOrientation!==3 ? parent.height : (root.theforce && !forcedOrientation ? 0.3 : 1) * parent.width)
        x: (forcedOrientation===1 || forcedOrientation===3 ? parent.width : (root.theforce && !forcedOrientation ? width*1.165 : 0))
        y: (forcedOrientation===2 || forcedOrientation===3 ? parent.height : - (root.theforce && !forcedOrientation ? height/4 : 0))

        layer.enabled: projectionManager.isEnabled
        layer.smooth: false
        layer.mipmap: false

        transform: Rotation {
            origin.x: 0; origin.y: 0;
            angle: switch (viewport.forcedOrientation) {
                case 1: return 90;
                case 2: return -90;
                case 3: return 180;
                default: return 0;
            }
            //Behavior on angle {
                //enabled: true
                //animation: NumberAnimation {
                    //duration: Kirigami.Units.longDuration
                    //easing.type: Easing.OutQuad
                //}
            //}
        }
        prompter.performFileOperations: true
        //Behavior on x {
            //enabled: true
            //animation: NumberAnimation {
                //duration: Kirigami.Units.longDuration
                //easing.type: Easing.OutQuad
            //}
        //}
        //Behavior on y {
            //enabled: true
            //animation: NumberAnimation {
                //duration: Kirigami.Units.longDuration
                //easing.type: Easing.OutQuad
            //}
        //}
        //Behavior on width {
            //enabled: viewport.forcedOrientation
            //animation: NumberAnimation {
                //duration: Kirigami.Units.longDuration
                //easing.type: Easing.OutQuad
            //}
        //}
        //Behavior on height {
            //enabled: viewport.forcedOrientation
            //animation: NumberAnimation {
                //duration: Kirigami.Units.longDuration
                //easing.type: Easing.OutQuad
            //}
        //}
    }

    // The following rectangles add a background that is shown behind the mobile action buttons when the user is in desktop mode but the action buttons are showing. These also improve contrast with the editor toolbar when opacity is active.
    // Action buttons are only supposed to be shown in desktop mode if the user is in fullscreen and not in the prompter's editing state, but there is a bug in Kirigami that causes it to appear under some circumstances or all of the time in desktop operating systems. Behavior varies from system to system.
    Rectangle {
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.top: prompterCutOffLine.bottom;
        // By extending over the editor we avoid seeing a cutoff in opaque mode and improve contrast
        height: 68 + editor.height
        //color: Kirigami.Theme.alternateBackgroundColor.a===0 ? Qt.rgba(appTheme.__backgroundColor.r*2/3, appTheme.__backgroundColor.g*2/3, appTheme.__backgroundColor.b*2/3, 1)
        //            : Qt.rgba(Kirigami.Theme.alternateBackgroundColor.r*2/3, Kirigami.Theme.alternateBackgroundColor.g*2/3, Kirigami.Theme.alternateBackgroundColor.b*2/3, 1)
        opacity: root.__opacity * 0.4 + 0.6
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            onWheel: (wheel)=>viewport.mouse.wheel(wheel)
        }
    }
    // The cut off line renders as a solid and doesn't cover the other rectangles to improve performance.
    Rectangle {
        id: prompterCutOffLine
        //color: Qt.rgba(Kirigami.Theme.activeBackgroundColor.r/4, Kirigami.Theme.activeBackgroundColor.g/8, Kirigami.Theme.activeBackgroundColor.b/6, 1)
        height: 3
        //height: Kirigami.Settings.isMobile ? 3 : 2
        anchors.left: parent.left;
        anchors.right: parent.right;
        //anchors.top: viewport.bottom;
        y: parent.height
    }

    // progress: parseInt(viewport.prompter.state)===Prompter.States.Prompting ? viewport.prompter.progress : undefined

    Labs.FontDialog {
        id: fontDialog
        //monospacedFonts: true
        //nonScalableFonts: true
        //proportionalFonts: true
        font: Qt.font({
            family: viewport.prompter.document.fontFamily,

            bold: viewport.prompter.document.bold,
            italic: viewport.prompter.document.italic,
            underline: viewport.prompter.document.underline,
            strikeout: viewport.prompter.document.strike,

            //overline: viewport.prompter.document.overline,
            //weight: viewport.prompter.document.weight,
            //capitalization: viewport.prompter.document.capitalization,
            //letterSpacing: viewport.prompter.document.letterSpacing,
            //wordSpacing: viewport.prompter.document.wordSpacing,
            //kerning: viewport.prompter.document.kerning,
            //preferShaping: viewport.prompter.document.preferShaping,
            //hintingPreference: viewport.prompter.document.hintingPreference,
            //styleName: viewport.prompter.document.styleName

            pointSize: ((editorToolbar.fontSizeSlider.value - editorToolbar.fontSizeSlider.from) * (72 - 6) / (editorToolbar.fontSizeSlider.to - editorToolbar.fontSizeSlider.from)) + 6
        })
        onAccepted: {
            viewport.prompter.document.fontFamily = font.family;

            viewport.prompter.document.bold = font.bold;
            viewport.prompter.document.italic = font.italic;
            viewport.prompter.document.underline = font.underline;
            viewport.prompter.document.strike = font.strikeout;

            //viewport.prompter.document.overline = font.overline;
            //viewport.prompter.document.weight = font.weight;
            //viewport.prompter.document.capitalization = font.capitalization;
            //viewport.prompter.document.letterSpacing = font.letterSpacing;
            //viewport.prompter.document.wordSpacing = font.wordSpacing;
            //viewport.prompter.document.kerning = font.kerning;
            //viewport.prompter.document.preferShaping = font.preferShaping;
            //viewport.prompter.document.hintingPreference = font.hintingPreference;
            //viewport.prompter.document.styleName = font.styleName;

            editorToolbar.fontSizeSlider.value = ((font.pointSize - 6) * (editorToolbar.fontSizeSlider.to - editorToolbar.fontSizeSlider.from) / (72 - 6)) + editorToolbar.fontSizeSlider.from
        }
    }

    Labs.ColorDialog {
        id: colorDialog
    }

    Labs.ColorDialog {
        id: highlightDialog
    }

    //MarkersDrawer {
        //id: sideDrawer
    //}

    //InputsOverlay {
        //id: key_configuration_overlay
    //}
}
