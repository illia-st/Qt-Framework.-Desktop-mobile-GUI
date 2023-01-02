import QtQuick 2.12
import Qt.labs.platform
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels




Window {
    Connections{
        target: viewer
        function onReadyToView(){
            console.log("Files have been updated");
            console.log("Updating ListModel");
            list_model.clear();
            table_model.clear();
            console.log(viewer.images);
            for(var i = 0; i < viewer.images.length; ++i){
                console.log(viewer.images[i]);
                list_model.append({path: viewer.images[i]});
                table_model.append({path: viewer.images[i]});
            }
        }
    }

    width: 640
    height: 480
    minimumHeight: 480
    minimumWidth: 640
    visible: true
    title: qsTr("Image viewer")

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 5
        RowLayout{
            Layout.alignment: Qt.AlignTop

            ColumnLayout{
                Layout.alignment: Qt.AlignLeft
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignRight
                Button{
                    id: selectFolderButton
                    text: "Click to select folder"
                    onClicked: folderDialog.open()
                }
                FolderDialog{
                    id: folderDialog
                    currentFolder: viewer.folder
                    folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                    onAccepted: viewer.parseFolder(folder)
                }
            }
        }
        ColumnLayout{
            Layout.fillWidth: true
            ListModel{
                id: list_model
            }

            ListView{
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true
                model: list_model
                delegate: Image{
                    source: path
                }
                ScrollBar.vertical: ScrollBar {}
            }
            TableModel{
                id: table_model
            }

            TableView{

            }

        }
    }
}
