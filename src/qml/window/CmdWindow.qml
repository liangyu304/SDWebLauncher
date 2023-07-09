import QtQuick
import FluentUI
import QtQuick.Controls 2.0

FluWindow {
    width: 1200
    height: 600

    id:window

    backgroundColor: "black"
    property string cmd_log: "wait....\n"

    // 关闭窗口
    FluContentDialog{
        id:close_app
        title:"退出"
        message:"确定要退出WebUi吗？"
        buttonFlags: FluContentDialog.NeutralButton | FluContentDialog.PositiveButton
        positiveText:"退出"
        neutralText:"取消"
        onPositiveClicked:{
            setVisible(false)
        }
    }
    closeFunc:function(event){
        close_app.open()
        event.accepted = false
    }

    Flickable{
        id:flickable
        clip: true
        anchors.fill: parent
        contentWidth: text_info.width
        contentHeight: text_info.height
        ScrollBar.vertical: FluScrollBar {
            id: scrol_bar
        }

        FluText {
            id:text_info
            text: cmd_log
            anchors.fill: window
            wrapMode: Text.WrapAnywhere
            padding: 14
            onTextChanged: {
                scrol_bar.increase()
            }
        }
    }

    // 接受 Webui实例的日志
    Connections {
        target: webUiControl
        onCmdChanged: {
            cmd_log += webUiControl.cmd
        }
    }

    // 顶部窗口
    FluAppBar {

    }
}
