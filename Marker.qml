import QtQuick 2.0

// Marker.qml
// The Image type as top level is convenient as the Marker component
// simply is a graphical UI with a clicked() signal.
Image {
    id: root

    // declaring the clicked() signal to be used in the MarkerPanel
    signal clicked()

    // this property indicates whether this marker item is the current
    // active one. Initially it is set to false
    property bool active: false

    // creating the two states representing the respective
    // set of property changes
    states: [
        // the hovered state is set when the user has the mouse hovering
        // the marker item.
        State {
            name: "hovered"
            //this condition makes this state active
            when: mouseArea.containsMouse && !root.active
            PropertyChanges { target: root; x: 5 }
        },

        State {
            name: "selected"
            when: root.active
            PropertyChanges { target: root; x: 20 }
        }
    ]

    // list of transitions that apply when the state changes
    transitions: [
        Transition {
            to: "hovered"
            NumberAnimation { target: root; property: "x"; duration: 300 }
        },

        Transition {
            to: "selected"
            NumberAnimation { target: root; property: "x"; duration: 300 }
        },

        //a transition for the default state
        Transition {
            to: ""
            NumberAnimation { target: root; property: "x"; duration: 300 }
        }
    ]

    // creating a MouseArea type to intercept the mouse click
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
