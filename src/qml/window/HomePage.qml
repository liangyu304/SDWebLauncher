import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI
import SdWebLauncher

FluScrollablePage{
    ListModel{
        id:model_header
        ListElement{
            icon:"qrc:/resource/image/ic_home_github.png"
            title:"SDWebLauncher GitHub"
            desc:"源码，用爱发电，多多支持"
            url:"https://github.com/liangyu304/SDWebLauncher"
        }
    }

    // 主页卡片，背景图
    Item{
        Layout.fillWidth: true
        height: 320
        Image {
            id: bg
            fillMode:Image.PreserveAspectCrop
            anchors.fill: parent
            verticalAlignment: Qt.AlignTop
            source: "qrc:/resource/image/bg_home_header.png"
        }
        Rectangle{
            anchors.fill: parent
            gradient: Gradient{
                GradientStop { position: 0.8; color: FluTheme.dark ? Qt.rgba(0,0,0,0) : Qt.rgba(1,1,1,0) }
                GradientStop { position: 1.0; color: FluTheme.dark ? Qt.rgba(0,0,0,1) : Qt.rgba(1,1,1,1) }
            }
        }

        ListView{
            id: list
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            orientation: ListView.Horizontal
            height: 240
            model: model_header
            header: Item{height: 10;width: 10}
            footer: Item{height: 10;width: 10}
            ScrollBar.horizontal: FluScrollBar{
                id: scrollbar_header
            }
            clip: false
            delegate:Item{
                id: control
                width: 220
                height: 240
                FluArea{
                    radius: 8
                    width: 200
                    height: 220
                    anchors.centerIn: parent
                    color: 'transparent'
                    FluAcrylic {
                        sourceItem:bg
                        anchors.fill: parent
                        color: FluTheme.dark ? Window.active ?  Qt.rgba(38/255,44/255,54/255,1) : Qt.rgba(39/255,39/255,39/255,1) : Qt.rgba(251/255,251/255,253/255,1)
                        rectX: list.x-list.contentX+10+(control.width)*index
                        rectY: list.y+10
                        acrylicOpacity:0.8
                    }
                    Rectangle{
                        anchors.fill: parent
                        radius: 8
                        color:{
                            if(FluTheme.dark){
                                if(item_mouse.containsMouse){
                                    return Qt.rgba(1,1,1,0.03)
                                }
                                return Qt.rgba(0,0,0,0)
                            }else{
                                if(item_mouse.containsMouse){
                                    return Qt.rgba(0,0,0,0.03)
                                }
                                return Qt.rgba(0,0,0,0)
                            }
                        }
                    }

                    ColumnLayout{
                        Image {
                            Layout.topMargin: 20
                            Layout.leftMargin: 20
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50
                            source: model.icon
                        }
                        FluText{
                            text: model.title
                            font: FluTextStyle.Body
                            Layout.topMargin: 20
                            Layout.leftMargin: 20
                        }
                        FluText{
                            text: model.desc
                            Layout.topMargin: 5
                            Layout.preferredWidth: 160
                            Layout.leftMargin: 20
                            color: FluColors.Grey120
                            font.pixelSize: 12
                            wrapMode: Text.WrapAnywhere
                        }
                    }
                    FluIcon{
                        iconSource: FluentIcons.OpenInNewWindow
                        iconSize: 15
                        anchors{
                            bottom: parent.bottom
                            right: parent.right
                            rightMargin: 10
                            bottomMargin: 10
                        }
                    }
                    MouseArea{
                        id:item_mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onWheel: (wheel)=>{
                            if (wheel.angleDelta.y > 0) scrollbar_header.decrease()
                            else scrollbar_header.increase()
                        }
                        onClicked: {
                            Qt.openUrlExternally(model.url)
                        }
                    }
                }
            }
        }
    }

    CmdWindow{
        id:cmd_window
        visible: false
        onVisibilityChanged: {
            if(visible == true){
                btn_start.text = "已启动"
            } else {
                btn_start.text = "启动"
            }
        }
    }

    // 启动按钮
    FluRectangle{
        id:btn_rectangle
        width: 300
        height: 100
        anchors{
            margins: 20
            right: parent.right
            bottom: parent.bottom
        }
        radius: 4
    }
    FluFilledButton{
        id: btn_start
        anchors.fill: btn_rectangle
        text:"启动"
        font:FluTextStyle.TitleLarge
        normalColor:"pink"
        onClicked: {
            if(btn_start.text === "启动"){
                webUiControl.StartWebUi();
                cmd_window.setVisible(true);
            }
        }
    }
}
