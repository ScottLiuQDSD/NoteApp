import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.LocalStorage 2.0
import "noteDB.js" as NoteDB


// main.qml

ApplicationWindow {
    // using window as the identifier for this item as
    // it will the only window of the NoteApp
    visible: true
    id: window
    width: 800; height: 600

    //creating a webfont property that holds the font
    //loading using FontLoader
    property variant webfont: FontLoader {
        source: "fonts/juleeregular.ttf"
        onStatusChanged: {
            if (webfontloader.status == FontLoader.Ready) {
                console.log('Loaded')
            }
        }
    }

    BorderImage {
        id: background
        anchors.fill: parent
        anchors.margins: -5
        source: "images/background.png"
        border.left: 70; border.top: 77
        border.right: 90; border.bottom: 91
    }

    // creating a MarkerPanel item
    MarkerPanel {
        id: markerPanel
        width: 120
        height: window.height
//        width: window.width - toolbar.width - markerPanel.width/2
//        x: window.width - 70

        anchors { right: parent.right; top: window.top; bottom: window.bottom
            topMargin: 30
        }
    }

    // creating a PagePanel item
    PagePanel {
        id: pagePanel
        state: markerPanel.activeMarker
        visible: true
        //height: window.height
        width: window.width - toolbar.width - markerPanel.width

        anchors { right: markerPanel.left; left: toolbar.right; top: parent.top; bottom: parent.bottom
            leftMargin: 1; rightMargin: -10; topMargin: 3; bottomMargin: 15
        }
        onStateChanged: console.log("state: " + state)
    }

    // the toolbar's background
    Rectangle {
        anchors.fill: toolbar
        color: "white"
        opacity: 0.15
        radius: 10
        border { color: "#600"; width: 4 }
    }

    // the toolbar -
    // using a Column type to layout the Tool items vertically
    Column {
        id: toolbar
        spacing: 16
        x: 8
        y: 30
        anchors {
            top: window.top; left: window.left; bottom: window.bottom;
            topMargin: 50; bottomMargin: 50; leftMargin: 8
        }

        //the `new note` tool, also known as the plus icon
        Tool {
            id: newNoteTool
            source: "images/add.png"
            onClicked: pagePanel.currentPage.newNote()
        }

        // the `clear` tool
        Tool {
            id: clearAllTool
            source: "images/clear.png"
            onClicked: pagePanel.currentPage.clear()
        }
    }

    // the quit tool on the righ bottom corner of NoteApp
    Tool {
        id: quitTool
        anchors {
            bottom: pagePanel.bottom; right: parent.right
            bottomMargin: 24; rightMargin: 28
        }
        source: "images/close.png"
        onClicked: Qt.quit()
    }

    // this signal is emitted up Component loading complition
    Component.onCompleted: {
        NoteDB.openDB()
    }
}
