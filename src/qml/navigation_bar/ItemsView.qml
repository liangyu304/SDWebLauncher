import QtQuick
import FluentUI

FluObject {
    property var navigationView

    FluPaneItem{
        title:"Home"
        icon:FluentIcons.Home
        cusIcon: Image{
            anchors.centerIn: parent
            source: FluTheme.dark ? "qrc:/resource/svg/home_dark.svg" : "qrc:/resource/svg/home.svg"
            sourceSize: Qt.size(30,30)
            width: 18
            height: 18
        }
        onTap:{
            navigationView.push("qrc:/window/HomePage.qml")
        }
    }
}
