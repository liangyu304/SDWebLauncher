import QtQuick
import QtQuick.Window 2.9
import TaoQuick 1.0

Window {
    width: 1280
    height: 720
    color: "white"
    visible: true
    title: qsTr("SD Web Ui Ly Launcher")

    Connections {
        target: backend
        onCppSignal: {
            console.log("C++ signal received")
        }
    }

    CusButton_Blue {
         width: 200
         height: 36
         anchors.centerIn: parent
         text: "Hello SD Web UI Launcher"
         onClicked: {
             backend.cppFunction();
             console.log("hello TaoQuick")
         }
     }
}
