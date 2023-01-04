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
            var row = {picture_1: "", picture_2: "", picture_3: ""};
            var cleared = true;
            for(var i = 0; i < viewer.images.length; ++i){
                console.log(viewer.images[i]);
                list_model.append({path: viewer.images[i]});
                if((i + 1) % 3 === 1){
                    row.picture_1 = viewer.images[i];
                    cleared = false;
                }else if((i + 1) % 3 === 2){
                    row.picture_2 = viewer.images[i];
                }else{
                    row.picture_3 = viewer.images[i];
                    table_model.appendRow(row);
                    row = {picture_1: "", picture_2: "", picture_3: ""};
                    cleared = true;
                }
            }
            if(!cleared){
                table_model.appendRow(row);
            }
        }
    }

    id: main_window
    width: 640
    height: 480
    minimumHeight: 480
    minimumWidth: 640
    visible: true
    title: qsTr("Image viewer")
    property int view_type: 0;
    function changeView(){
        if(view_type === 0){
            list_view.visible = true;
            table_view.visible = false;
            path_view.visible = false;
        }else if(view_type === 1){
            list_view.visible = false;
            table_view.visible = true;
            path_view.visible = false;
        }else{
            list_view.visible = false;
            table_view.visible = false;
            path_view.visible = true;
        }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 5
        RowLayout{
            Layout.alignment: Qt.AlignTop
            ColumnLayout{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                Button{
                    id: menuButton
                    text: "View type"
                    onClicked: menu.open()
                    Menu{
                        id: menu
                        MenuItem{
                            text: "ListView"
                            onTriggered:{
                                view_type = 0;
                                changeView();
                            }
                        }
                        MenuItem{
                            text: "TableView"
                            onTriggered:{
                                view_type = 1;
                                changeView();
                            }
                        }
                        MenuItem{
                            text: "PathView"
                            onTriggered:{
                                view_type = 2;
                                changeView();
                            }
                        }
                    }
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Button{
                    id: selectFolderButton
                    text: "Click to select folder"
                    onClicked: folderDialog.open()
                    FolderDialog{
                        id: folderDialog
                        currentFolder: viewer.folder
                        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                        onAccepted: viewer.parseFolder(folder)
                    }
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignTop
            Rectangle{
                id: canvas
                color: "red"
//                anchors.fill: parent
                Layout.fillHeight: true
                Layout.fillWidth: true
                ListModel{
                    id: list_model
                }
                ListView{
                    visible: true
                    id: list_view
                    anchors.fill: parent
                    clip: true
                    model: list_model
                    delegate: Rectangle{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 100;
                        anchors.bottomMargin: 100;
                        width: 400
                        height: 300
                        Image{
                            anchors.fill: parent
                            width: 400
                            height: 300
                            source: path
                          MouseArea{
                                property bool big: false
                                anchors.fill: parent
                                onClicked:{
                                    if(big){
                                        parent.width = canvas.width;
                                        parent.parent.width = canvas.width;
                                    }else{
                                        parent.width = 400;
                                        parent.parent.width = 400;
                                    }

                                    big = !big;
                                }
                            }
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                }

                TableModel{
                    id: table_model
                    TableModelColumn {display: "picture_1"}
                    TableModelColumn {display: "picture_2"}
                    TableModelColumn {display: "picture_3"}
                }

                TableView{
                    anchors.fill: parent
                    id: table_view
                    visible: false
                    model: table_model
                    delegate:Rectangle{
                        id: base
                        implicitHeight: 250
                        implicitWidth: 225
                        Image{
                            anchors.fill: parent
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            fillMode: Image.PreserveAspectFit
                            source: model.display
                            height: base.height - 50
                            width: base.width - 50
                          MouseArea{
                                property bool big: false
                                anchors.fill: parent
                                onClicked:{
                                    if(!big){
                                        parent.width = parent.width + 50;
                                        parent.height = parent.height + 50;
                                    }else{
                                        parent.width = parent.width - 50;
                                        parent.height = parent.height - 50;
                                    }


                                    big = !big;
                                }
                            }
                        }
                    }
                    ScrollBar.vertical: ScrollBar {}
                }

                PathView{
                    id: path_view
                    anchors.fill: parent
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.horizontalCenter: parent.horizontalCenter
                    model: list_model
                    visible: false
                    delegate: Column{
                        id: wrapper
                        opacity: PathView.isCurrentItem ? 1 : 0.5
                        Image{
                            width: 64; height: 64
                            source: path
                            MouseArea{
                                  property bool big: false
                                  anchors.fill: parent
                                  onClicked:{
                                      if(!big){
                                          parent.width *= 2;
                                          parent.height *= 2;
                                      }else{
                                          parent.width /= 2;
                                          parent.height /= 2;
                                      }
                                      big = !big;
                                  }
                              }
                        }
                    }
                    path: Path {
                        startX: 120; startY: 100
                        PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
                        PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
                    }
                }
            }
        }

    }
}

