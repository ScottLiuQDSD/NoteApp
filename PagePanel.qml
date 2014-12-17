import QtQuick 2.0
import "noteDB.js" as NoteDB

// PagePane.qml

Item {
    id: root

    // this property holds the current visible page
    property Page currentPage: personalpage

    // setting an initial value for the state property
    state: "personal"

    // creating the list of states
    states: [
        //creating a State item with its corresponding name
        State {
            name: "personal"
            PropertyChanges { target: personalpage; opacity:1.0; restoreEntryValues: true }
            PropertyChanges { target: root; currentPage: personalpage; explicit: true }
        },

        State {
            name: "fun"
            PropertyChanges { target: funpage; opacity:1.0; restoreEntryValues: true }
            PropertyChanges { target: root; currentPage: funpage;  explicit: true }
        },
        State {
            name: "work"
            PropertyChanges { target: workpage; opacity:1.0; restoreEntryValues: true }
            PropertyChanges { target: root; currentPage: workpage; explicit: true }
        }
    ]

    // creating a list of transitions for the different states of the PagePanel
    transitions: [
        Transition {
            //for all states run the same transition
            from: "*"; to: "*"
            NumberAnimation { property: "opacity"; duration: 500 }
        }
    ]

    BorderImage {
        id: background
        anchors.fill: parent
        source: "images/page.png"
        border.left: 68; border.top: 69
        border.right: 40; border.bottom: 80
    }

    // creating three Page items that are anchored to fill the parent.
    Page { id: personalpage; anchors.fill: parent; markerId: "personal" }
    Page { id: funpage; anchors.fill: parent; markerId: "fun" }
    Page { id: workpage; anchors.fill: parent; markerId: "work" }

    Component.onDestruction: saveNotesToDB()

    // a javascript function that saves all notes from the pages
    function saveNotesToDB() {
        // clearing the DB table before populating with new data
        NoteDB.clearNoteTable();

        //storing notes for each individual page
        NoteDB.saveNotes(personalpage.notes, personalpage.markerId)
        NoteDB.saveNotes(funpage.notes, funpage.markerId)
        NoteDB.saveNotes(workpage.notes, workpage.markerId)
    }
}
