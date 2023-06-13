import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import FluentUI

import "../component"
import "../navigation_bar"

CustomWindow {

    id:window
    title: "Ly SdWebUi Launcher"
    width: 1280
    height: 720
    closeDestory:false
    minimumWidth: 520
    minimumHeight: 460
    appBarVisible: false
    launchMode: FluWindow.SingleTask

    closeFunc:function(event){
        close_app.open()
        event.accepted = false
    }

    Connections{
        target: appInfo
        function onActiveWindow(){
            window.show()
            window.raise()
            window.requestActivate()
        }
    }

    SystemTrayIcon {
        id:system_tray
        visible: true
        icon.source: "qrc:/resource/ico/test.ico"
        tooltip: "Ly SdWebUi Launcher"
        menu: Menu {
            MenuItem {
                text: "退出"
                onTriggered: {
                    window.deleteWindow()
                    FluApp.closeApp()
                }
            }
        }
        onActivated:
            (reason)=>{
                if(reason === SystemTrayIcon.Trigger){
                    window.show()
                    window.raise()
                    window.requestActivate()
                }
            }
    }

    FluContentDialog{
        id:close_app
        title:"退出"
        message:"确定要退出程序吗？"
        negativeText:"最小化"
        buttonFlags: FluContentDialog.NeutralButton | FluContentDialog.NegativeButton | FluContentDialog.PositiveButton
        onNegativeClicked:{
            system_tray.showMessage("友情提示","FluentUI已隐藏至托盘,点击托盘可再次激活窗口");
            window.hide()
        }
        positiveText:"退出"
        neutralText:"取消"
        blurSource: nav_view
        onPositiveClicked:{
            window.deleteWindow()
            FluApp.closeApp()
        }
    }

    FluAppBar {
        id: title_bar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        darkText: "主题切换"
        showDark: true
        z:7
    }

    ItemsView{
        id:items_view
    }

    ItemsFooter{
        id:items_footer
    }


    FluNavigationView{
        id: nav_view
        title: "导航栏"
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        items: items_view
        footerItems:items_footer
        logo: "qrc:/resource/ico/test.ico"
        autoSuggestBox:FluAutoSuggestBox{
            width: 280
            anchors.centerIn: parent
            iconSource: FluentIcons.Search
            items: items_view.getSearchData()
            placeholderText: lang.search
            onItemClicked:
                (data)=>{
                    items_view.startPageByItem(data)
                }
        }
        Component.onCompleted: {
            items_view.navigationView = nav_view
            items_footer.navigationView = nav_view
            nav_view.setCurrentIndex(0)
        }
    }
}
