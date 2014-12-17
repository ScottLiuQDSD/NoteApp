import QtQuick 2.0

// NoteToolbar.qml

Item {
    id: root
    width: 100
    height: 62

    //this signal is emitted when the toolbar is pressed by the user
    signal pressed()

    BorderImage {
        source: "images/notetoolbar.png"
        anchors.fill: parent
        border.left: 10; border.top: 10
        border.right: 10; border.bottom: 10
    }

    //declaring a property alias to the drag property of MouseArea type
    property alias drag: mousearea.drag

    //this default property enables us to create QML Items that will be automatically
    //laid out in the Row type and considered as toolItems
    default property alias toolItems: layout.children

    MouseArea {
        id: mousearea
        anchors.fill: parent

        //setting hoverEnabled property to true in order for the MouseArea to be able to get
        //hover events
        hoverEnabled: true

        //emitting the pressed() signal on a mouse press event
        onPressed: root.pressed()
    }

    //using a Row type for laying out tool items to be added when using the NoteToolbar
    Row {
        id: layout
        layoutDirection: Qt.RightToLeft
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right
            leftMargin: 15; rightMargin: 15
        }
        spacing: 20

        //the opacity depends if the mousearea types has the cursor of the mouse.
        opacity: mousearea.containsMouse ? 1 : 0

        //using the behavior type to specify the behavior of the layout type
        //when on the opacity changes.
        Behavior on opacity {
            //Using NumberAnimation to animate the opacity value in a duration of 350 ms
            NumberAnimation { duration: 350 }
        }
    }
}
