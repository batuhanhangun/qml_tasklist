

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.4
import QtQuick.Controls 6.4
import TaskListApp
import QtQuick.Layouts 1.0

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor
    property bool isDialogOpen: false

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 102
        anchors.topMargin: 48

        Repeater {
            id: repeater
            anchors.fill: parent
            layer.enabled: false
            model: ListModel {
            id: myListModel
               /* ListElement{
                name: "My Task"
                } */
                function createListElement(){
                    //Can't add more than 8 tasks to fit in screen
                    if(taskTextInput.text !== "" && repeater.count < 8){
                        return {
                            "name": taskTextInput.text
                      }
                    }
                }
            }

            Rectangle {
                id: taskItem
                x: -2
                y: 33
                width: 382
                height: 74
                visible: true
                color: "#d6d7d7"
                radius: 15
                border.color: "#b3a1a1"
                enabled: true

                CheckBox {
                    id: checkBox
                    height: 45
                    text: name
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pointSize: 22
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 3
                }

                Button {
                    id: removeTaskButton
                    x: 340
                    y: 5
                    text: qsTr("X")
                    scale: -0.706

                    Connections {
                        target: removeTaskButton
                        onClicked:
                            /* Ability to remove tasks from the
                            list if they are checked */
                            function removeTaskFromList(){
                                if(checkBox.checkState === Qt.Checked){
                                    myListModel.remove(index)
                                }
                            }
                    }
                }
            }
        }
    }


    Rectangle {
        id: addNewTaskDialog
        x: 10
        y: 584
        width: 380
        height: 152
        visible: rectangle.isDialogOpen
        color: "#d6d7d7"
        radius: 15
        border.color: "#b3a1a1"

        TextField {
            id: taskTextInput
            height: 60
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pointSize: 20
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.topMargin: 25
            placeholderText: qsTr("Write a new task...")
        }

        RowLayout {
            x: 8
            y: 91
            width: 364
            height: 48
            spacing: 50
            Button {
                id: addButton
                width: 139
                text: qsTr("Add Task")
                Layout.fillWidth: true

                Connections {
                    target: addButton
                    onClicked: rectangle.isDialogOpen = false

                }

                Connections {
                    target: addButton
                    onClicked: myListModel.append(myListModel.createListElement())
                }


            }

            Button {
                id: cancelButton
                text: qsTr("Cancel")
                Layout.fillWidth: true

                Connections {
                    target: cancelButton
                    onClicked: rectangle.isDialogOpen = false

                }

                Connections {
                    target: cancelButton
                    onClicked: taskTextInput.text = ""
                }
            }
        }
    }

    Button {
        id: addNewTaskButton
        y: 720
        height: 48
        text: qsTr("Add New Task")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        Connections {
            target: addNewTaskButton
            onClicked: rectangle.isDialogOpen = !rectangle.isDialogOpen
        }

        //After adding a task, task input text is cleared
        Connections {
            target: addNewTaskButton
            onClicked: taskTextInput.text = ""
        }
    }

    Text {
        id: titleText
        text: qsTr("Task List")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 150
        anchors.leftMargin: 150
        anchors.topMargin: 8
    }

    states: [
        State {
            name: "clicked"
            when: addNewTaskButton.checked
        }
    ]
}
