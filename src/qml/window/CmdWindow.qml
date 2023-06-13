import QtQuick
import FluentUI

FluWindow {
    width: 1200
    height: 600

    backgroundColor: "black"

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

    FluText{
        id:text_info
        width: parent.width
        wrapMode: Text.WrapAnywhere
        padding: 14
    }
}
