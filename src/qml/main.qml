import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI
import "./window"

Window {
    id:app
    Component.onCompleted: {
        FluApp.init(app)
        FluTheme.darkMode = FluDarkMode.System
        FluApp.routes = {
            "/":"qrc:/window/MainWindow.qml",
        }
        FluApp.initialRoute = "/"
        FluApp.run()
    }
}
