import QtQuick 2.0

// Tool.qml

// Use Image as the top level type
Image {
    id: root

    //defining the clicked signal
    signal clicked()

    //using a MouseArea type to capture the mouse click of the user
    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
