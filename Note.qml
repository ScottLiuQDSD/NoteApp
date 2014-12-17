import QtQuick 2.0

// Note.qml
Item {
    id: root
    width: 200; height: 200
    visible: true

    property string markerId
    property int noteId
    property alias noteText: editArea.text
    property string imagePath: "./images/" + markerId + "_note.png"


    // this property holds the container of notes
    // and is used to retrieve values for the maximum and minimum
    // dragging areas
    property variant container

    // setting the z order to 1 if the text area has the focus
    z: editArea.activeFocus ? 1:0

    BorderImage {
        id: noteImage
        anchors { fill: parent }
        source: imagePath
        border.left: 20; border.top: 20
        border.right: 20; border.bottom: 20
    }

    // creating a NoteToolbar item that will be anchored to its parent
    NoteToolbar {
        id: toolbar
        height: 40
        anchors { top: root.top; left: root.left; right: root.right }

        // using the drag property alias to set the drag.target to our Note item.
        drag.target: root

        // specifying the maximum and minimum dragging areas for the note
        drag.minimumX: root.container.x; drag.maximumX: root.container.width - root.width
        drag.minimumY: root.container.y; drag.maximumY: root.container.height - root.height

        // setting the focus on the text area when the toolbar is pressed
        onPressed: editArea.focus = true

        // creating the `delete` tool for deleting the note item
        Tool {
            id: deleteItem
            source: "images/delete.png"
            onClicked: root.destroy()
        }
    }

    // creating a TextEdit item
    TextEdit {
        id: editArea
        height: 150
        anchors { top: toolbar.bottom; left: parent.left; right: parent.right
            topMargin: 0; leftMargin: 20; rightMargin: 20; bottomMargin: 100
        }

        color: "blue"
        selectByMouse: true
        wrapMode: TextEdit.WrapAnywhere
        font.family: window.webfont.name; font.pointSize: 13

        // called when the painterHeight property changes
        // then the note height has to be updated based on the text input
        onPaintedHeightChanged: updateNoteHeight()
    }

    // defining a behavior when the height property changes for root type
    Behavior on height { NumberAnimation { easing.type: Easing.InCubic} }

    // javascript helper function that calculates the height of the note
    // as more text input is entered or removed.
    function updateNoteHeight() {
        var noteMinHeight = 200
        var currentHeight = editArea.paintedHeight + toolbar.height +40;
        root.height = noteMinHeight

        if (currentHeight >= noteMinHeight)
            root.height = currentHeight
    }
}
