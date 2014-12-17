import QtQuick 2.0

import "noteDB.js" as NoteDB

// Page.qml

Item {
    id: root
    // by default a page should not be visible,
    // page's visibility is mananged by the PagePanel
    // the opacity property is sufficient
    opacity: 0.0

    // this property is held for helping to store the note
    // items in the database
    property string markerId

    // this property is used by the PagePanel componet
    // for retrieving all the notes of a page and storing
    // them in the Database.
    property alias notes: container.children

    // loading the Note Component
    Component {
        id: noteComponent
        Note { visible: true }
    }

    // creting an Item type that will be used as a note container
    // we anchor the container to fill the parent as it will be used
    // later in the code to control the dragging area for notes
    Item { id: container; anchors.fill: parent }

    // when the Component is loaded then the call the loadNotes() function
    // to load notes from the database
    Component.onCompleted: loadNotes()

    // a helper Javascript function that is reads the note data from DB
    function loadNotes() {
        var noteItems = NoteDB.readNotesFromPage(markerId)
        for (var i in noteItems) {
            newNoteObject(noteItems[i])
        }
    }

    // a Javascript helper function for creating Note QML objects
    function newNoteObject(args) {
        // setting the container property of the note to the
        // actual container see Note.qml what the container
        // property is used for
        args.container = container

        // calling the createObject() function on the noteComponent
        // for creating Note objects.
        // the container will be the parent of the new object
        // and args as the set of arguments
        var note = noteComponent.createObject(container, args)
        if (note === null) {
            console.log("note object failed to be created!")
        }
    }

    // a Javascript helper function for iterating through
    // the children types of the container item
    // and calls destroy() for deleting them
    function clear () {
        for (var i = 0; i < container.children.length; ++i) {
            container.children[i].destroy()
        }
    }

    // this Javascript helper function is used to create,
    // not loaded from db, Note items so that it will
    // set the markerId property of the note.
    function newNote() {
        // calling the newNoteObject and passing the a set of arguments where the markerId is set.
        newNoteObject( {"markerId": root.markerId} )
    }

}
