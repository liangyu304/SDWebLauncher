import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import FluentUI

import "../component"

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
        darkText: lang.dark_mode
        showDark: true
        z:7
    }

    FluObject{
        property var navigationView

        id:test
        FluPaneItem{
            title:lang.home
            icon:FluentIcons.Home
                   cusIcon: Image{
                       anchors.centerIn: parent
                       source: FluTheme.dark ? "qrc:/resource/svg/home_dark.svg" : "qrc:/resource/svg/home.svg"
                       sourceSize: Qt.size(30,30)
                       width: 18
                       height: 18
                   }
            onTap:{
                navigationView.push("qrc:/example/qml/page/T_Home.qml")
            }
        }
    }

    FluNavigationView{
        id:nav_view
        width:200
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        z:999
        items: test
        footerItems:ItemsFooter
        topPadding:FluTools.isMacos() ? 20 : 5
        displayMode:MainEvent.displayMode
        logo: "qrc:/resource/ico/test.ico"
        title:"FluentUI"
        autoSuggestBox:FluAutoSuggestBox{
            width: 280
            anchors.centerIn: parent
            iconSource: FluentIcons.Search
            items: ItemsOriginal.getSearchData()
            placeholderText: lang.search
            onItemClicked:
                (data)=>{
                    ItemsOriginal.startPageByItem(data)
                }
        }
        Component.onCompleted: {
            ItemsOriginal.navigationView = nav_view
            ItemsFooter.navigationView = nav_view
            test.navigationView = nav_view
            nav_view.setCurrentIndex(0)
        }
    }
}
