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
//            table_model.clear();
//            console.log(viewer.images);
            for(var i = 0; i < viewer.images.length; ++i){
                console.log(viewer.images[i]);
                list_model.append({path: viewer.images[i]});
//                table_model.append({path: viewer.images[i]});
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
        }else if(view_type === 1){
            list_view.visible = false;
            table_view.visible = true;
        }else{

        }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 5
        GridLayout{
            Layout.alignment: Qt.AlignTop
            columns: 2
            Button{
                Layout.column: 0
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
            Button{
                Layout.column: 1
                Layout.alignment: Qt.AlignRight
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
        RowLayout{
            Layout.alignment: Qt.AlignTop
            Rectangle{
                id: canvas
                color: "red"
                Layout.fillHeight: true
                Layout.fillWidth: true
                ListModel{
                    id: list_model
                    ListElement{
                        path: "file://home/illia_st/Downloads/melih-karaahmet-fb-Yqt_f9DQ-unsplash.jpg"
                    }
                    ListElement{
                        path: "file://home/illia_st/Downloads/melih-karaahmet-Tkz9YXDn3FY-unsplash.jpg"
                    }
                    ListElement{
                        path: "file://home/illia_st/Downloads/tower_backlight_night_city_137081_1920x1080.jpg"
                    }
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
                    rows:[
                        {
                            picture_1: "file://home/illia_st/Downloads/melih-karaahmet-fb-Yqt_f9DQ-unsplash.jpg",
                            picture_2: "file://home/illia_st/Downloads/melih-karaahmet-Tkz9YXDn3FY-unsplash.jpg",
                            picture_3: "file://home/illia_st/Downloads/tower_backlight_night_city_137081_1920x1080.jpg"
                        }
                    ]
                }

                TableView{
                    id: table_view
                    visible: false
                    model: table_model
                    delegate:DelegateChooser{
                         DelegateChoice{
                             column: 0
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
                                     source: model.display
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
                         }
                         DelegateChoice{
                             column: 1
                             delegate: Rectangle{
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 anchors.topMargin: 100;
                                 anchors.bottomMargin: 100;
                                 implicitWidth: 400
                                 implicitHeight: 300
                                 Image{
                                     anchors.fill: parent
                                     width: 400
                                     height: 300
                                     source: model.display
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
                         }
                         DelegateChoice{
                             column: 2
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
                                     source: model.display
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
                         }
                    }
                }
            }
        }

    }
}

