import QtQuick 2.0

// MarkerPanel.qml

Item {
    id: root
    width: 150; height: 450

    // a property of type string to hold the value of the current active marker
    property string activeMarker: "personal"

    // a list for holding respective data for a Marker item.
    property variant markerData: [
        { img: "images/personalmarker.png", markerId: "personal" },
        { img: "images/funmarker.png", markerId: "fun" },
        { img: "images/workmarker.png", markerId: "work" }
    ]

    Column {
        id: layout
        anchors.fill: parent
        spacing: 5
        property int activeMarker

        Repeater {
            // using the defined list as our model
            model: markerData
            delegate:
                Marker {
                    id: marker

                // the active property of the Marker is true only when the marker
                // item is the one current active one set on the onClicked signal
                active: layout.activeMarker == index

                    source: modelData.img

                // handling the clicked signal of the Marker item, setting the currentMarker property
                // of MarkerPanel based on the clicked Marker
                    onClicked: {
                    layout.activeMarker = index
                        root.activeMarker = modelData.markerId
                    }
                }
        }
    }
}
