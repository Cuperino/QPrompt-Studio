import QtQuick 2.6
import QtQuick.Controls 2.15

MenuBar {
    // id: nativeMenus
    // window: root
    // menus: [
    Menu {
        title: qsTr("&File", "Global menu actions")

        Action {
            text: qsTr("&New", "Main menu and global menu actions")
            onTriggered: viewport.document.newDocument()
        }
        Action {
            text: qsTr("&Open", "Main menu and global menu actions")
            onTriggered: viewport.document.open()
        }
        Action {
            text: qsTr("&Save", "Main menu and global menu actions")
            onTriggered: viewport.document.saveDialog()
        }
        Action {
            text: qsTr("Save &As…", "Main menu and global menu actions")
            onTriggered: viewport.document.saveAsDialog()
        }
        MenuSeparator { }
        Action {
            text: qsTr("&Quit", "Main menu and global menu actions")
            onTriggered: close()
        }
    }

    Menu {
        title: qsTr("&Edit", "Global menu actions")

        Action {
            text: qsTr("&Undo", "Global menu actions")
            enabled: viewport.editor.canUndo
            onTriggered: viewport.editor.undo()
        }
        Action {
            text: qsTr("&Redo", "Global menu actions")
            enabled: viewport.editor.canRedo
            onTriggered: viewport.editor.redo()
        }
        MenuSeparator { }
        Action {
            text: qsTr("&Copy", "Global menu and editor context menu actions")
            enabled: viewport.editor.selectedText
            onTriggered: viewport.editor.copy()
        }
        Action {
            text: qsTr("Cu&t", "Global menu and editor context menu actions")
            enabled: viewport.editor.selectedText
            onTriggered: viewport.editor.cut()
        }
        Action {
            text: qsTr("&Paste", "Global menu and editor context menu actions")
            enabled: viewport.editor.canPaste
            onTriggered: viewport.editor.paste()
        }
    }

    Menu {
        title: qsTr("&View", "Global menu actions")

        Action {
            text: qsTr("Full &screen", "Global menu actions")
            //visible: !fullScreenPlatform
            checkable: true
            checked: root.__fullScreen
            onTriggered: root.__fullScreen = !root.__fullScreen
        }
        //Action {
        //    text: qsTr("&Auto full screen")
        //    checkable: true
        //    checked: root.__autoFullScreen
        //    onTriggered: root.__autoFullScreen = !root.__autoFullScreen
        //}
        MenuSeparator { }
        Menu {
            title: qsTr("&Indicators", "Global menu actions. Indicators highlight reading region.")
            Action {
                text: qsTr("&Left Pointer", "Global menu actions. Shows pointer to the left of the reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.LeftPointer
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.LeftPointer
            }
            Action {
                text: qsTr("&Right Pointer", "Global menu actions. Shows pointer to the right of the reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.RightPointer
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.RightPointer
            }
            Action {
                text: qsTr("B&oth Pointers", "Global menu actions. Shows pointers to the left and right of the reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.Pointers
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.Pointers
            }
            MenuSeparator { }
            Action {
                text: qsTr("&Bars", "Global menu actions. Translucent bars indicate reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.Bars
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.Bars
            }
            Action {
                text: qsTr("Bars Lef&t", "Global menu actions. Translucent bars and left pointer indicate reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.BarsLeft
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.BarsLeft
            }
            Action {
                text: qsTr("Bars Ri&ght", "Global menu actions. Translucent bars and right pointer indicate reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.BarsRight
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.BarsRight
            }
            MenuSeparator { }
            Action {
                text: qsTr("&All", "Global menu actions. Enable all reading region indicators.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.All
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.All
            }
            Action {
                text: qsTr("&Hidden", "Global menu actions. Disable all reading region indicators.")
                checkable: true
                checked: parseInt(viewport.overlay.styleState) === ReadRegionOverlay.PointerStates.None
                onTriggered: viewport.overlay.styleState = ReadRegionOverlay.PointerStates.None
            }
        }
        Menu {
            title: qsTr("Readin&g region", "Global menu actions. Reading region indicates where a talent should be reading from.")
            Action {
                text: qsTr("&Top", "Global menu actions. Align reading region to top of prompter.")
                checkable: true
                checked: parseInt(viewport.overlay.positionState) === ReadRegionOverlay.PositionStates.Top
                onTriggered: viewport.overlay.positionState = ReadRegionOverlay.PositionStates.Top
            }
            Action {
                text: qsTr("&Middle", "Global menu actions. Align reading region to vertical center of prompter.")
                checkable: true
                checked: parseInt(viewport.overlay.positionState) === ReadRegionOverlay.PositionStates.Middle
                onTriggered: viewport.overlay.positionState = ReadRegionOverlay.PositionStates.Middle
            }
            Action {
                text: qsTr("&Bottom", "Global menu actions. Align reading region to bottom of prompter.")
                checkable: true
                checked: parseInt(viewport.overlay.positionState) === ReadRegionOverlay.PositionStates.Bottom
                onTriggered: viewport.overlay.positionState = ReadRegionOverlay.PositionStates.Bottom
            }
            MenuSeparator { }
            Action {
                text: qsTr("F&ree placement", "Global menu actions. Enables drag and drop positioning of reading region.")
                checkable: true
                checked: parseInt(viewport.overlay.positionState) === ReadRegionOverlay.PositionStates.Free
                onTriggered: viewport.overlay.positionState = ReadRegionOverlay.PositionStates.Free
            }
            Action {
                text: qsTr("C&ustom (Fixed placement)", "Global menu actions. Fix positioning of reading region to what was set in \"Free placement\" mode.")
                checkable: true
                checked: parseInt(viewport.overlay.positionState) === ReadRegionOverlay.PositionStates.Fixed
                onTriggered: viewport.overlay.positionState = ReadRegionOverlay.PositionStates.Fixed
            }
        }
    }

    Menu {
        title: qsTr("For&mat", "Global menu actions")

        Action {
            text: qsTr("&Bold", "Global menu actions")
            checkable: true
            checked: viewport.document.bold
            onTriggered: viewport.document.bold = !viewport.document.bold
        }
        Action {
            text: qsTr("&Italic", "Global menu actions")
            checkable: true
            checked: viewport.document.italic
            onTriggered: viewport.document.italic = !viewport.document.italic
        }
        Action {
            text: qsTr("&Underline", "Global menu actions")
            checkable: true
            checked: viewport.document.underline
            onTriggered: viewport.document.underline = !viewport.document.underline
        }
        MenuSeparator { }
        Action {
            text: Qt.application.layoutDirection===Qt.LeftToRight ? qsTr("Align &Left", "Global menu and editor actions. Text alignment.") : qsTr("Align &Right", "Global menu and editor actions. Text alignment.")
            checkable: true
            checked: Qt.application.layoutDirection===Qt.LeftToRight ? viewport.document.alignment === Qt.AlignLeft : viewport.document.alignment === Qt.AlignRight
            onTriggered: {
                if (Qt.application.layoutDirection===Qt.LeftToRight)
                    viewport.document.alignment = Qt.AlignLeft
                else
                    viewport.document.alignment = Qt.AlignRight
            }
        }
        Action {
            text: qsTr("Align Cen&ter", "Global menu actions. Text alignment.")
            checkable: true
            checked: viewport.document.alignment === Qt.AlignHCenter
            onTriggered: viewport.document.alignment = Qt.AlignHCenter
        }
        Action {
            text: Qt.application.layoutDirection===Qt.LeftToRight ? qsTr("Align &Right", "Global menu actions. Text alignment.") : qsTr("Align &Left", "Global menu actions. Text alignment.")
            checkable: true
            checked: Qt.application.layoutDirection===Qt.LeftToRight ? viewport.document.alignment === Qt.AlignRight : viewport.document.alignment === Qt.AlignLeft
            onTriggered: {
                if (Qt.application.layoutDirection===Qt.LeftToRight)
                    viewport.document.alignment = Qt.AlignRight
                else
                    viewport.document.alignment = Qt.AlignLeft
            }
        }
        // Justify is proven to make text harder to read for some readers. So I'm commenting out all text justification options from the program. I'm not removing them, only commenting out in case someone needs to re-enable. This article links to various sources that validate my decision: https://kaiweber.wordpress.com/2010/05/31/ragged-right-or-justified-alignment/ - Javier
        //Action {
        //    text: qsTr("Global menu actions. Text alignment.", "Align &Justify")
        //    checkable: true
        //    checked: viewport.document.alignment === Qt.AlignJustify
        //    onTriggered: viewport.document.alignment = Qt.AlignJustify
        //}
        MenuSeparator { }
        Action {
            text: qsTr("C&haracter", "Global menu actions. Opens dialog to format currently selected text.")
            onTriggered: root.pageStack.currentItem.fontDialog.open();
        }
        Action {
            text: qsTr("Fo&nt Color", "Global menu actions. Opens dialog to color currently selected text.")
            onTriggered: viewport.colorDialog.open()
        }
    }

    Menu {
        title: qsTr("Controls", "Global menu actions. Menu regarding input settings.")

        Action {
            text: qsTr("Disable scrolling while prompting", "Main menu and global menu actions. Touchpad scrolling and mouse wheel use have no effect while prompting.")
            checkable: true
            checked: root.__noScroll
            onTriggered: root.__noScroll = !root.__noScroll
        }
        Action {
            text: qsTr("Use scroll as velocity &dial", "Main menu and global menu actions. Have touchpad and mouse wheel scrolling adjust velocity instead of scrolling like most other apps.")
            enabled: !root.__noScroll
            checkable: true
            checked: root.__scrollAsDial
            onTriggered: root.__scrollAsDial = !root.__scrollAsDial
        }
        MenuSeparator { }
        Action {
            text: qsTr("Invert &arrow keys", "Main menu and global menu actions. Have up arrow behave like down arrow and vice versa while prompting.")
            enabled: !root.__noScroll
            checkable: true
            checked: root.__invertArrowKeys
            onTriggered: root.__invertArrowKeys = !root.__invertArrowKeys
        }
        Action {
            text: qsTr("Invert &scroll direction", "Main menu and global menu actions. Invert scroll direction while prompting.")
            enabled: !root.__noScroll
            checkable: true
            checked: root.__invertScrollDirection
            onTriggered: root.__invertScrollDirection = !root.__invertScrollDirection
        }
    }

    Menu {
        title: qsTr("&View")
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
            text: qsTr("Restore defaults")
            onTriggered: {
                // Not implemented
            }
        }
        // Action {
        //     text: qsTr("Close All")
        //     onTriggered: {
        //         _kddwDockRegistry.clear();
        //     }
        // }
    }

    Menu {
        title: qsTr("&Help", "Global menu actions")

        Action {
            text: qsTr("Report &Bug…", "Global menu actions")
            onTriggered: Qt.openUrlExternally("https://feedback.qprompt.app")
            icon.name: "tools-report-bug"
        }
        MenuSeparator { }
        //Action {
        //     visible: false
        //     text: qsTr("Get &Studio Edition")
        //     onTriggered: Qt.openUrlExternally("https://studio.qprompt.app/")
        //     icon.name: "software-center"
        //}
        //MenuSeparator { }
        Action {
            text: qsTr("Load &Welcome", "Main menu and global actions. Load document that welcomes users.")
            icon.name: "help-info"
            onTriggered: viewport.document.loadGuide()
        }
        MenuSeparator { }
        Action {
            text: qsTr("Abou&t %1", "Global menu actions. Load about page. \"About AppName\"").arg(root.displayName)
            onTriggered: root.loadAboutPage()
            icon.source: "qrc:/images/qprompt-logo-wireframe.png"
        }
    }
    //]
}
