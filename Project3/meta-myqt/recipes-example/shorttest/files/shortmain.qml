import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Text {
        id: text1
        x: 246
        y: 238
        width: 128
        height: 22
        text: qsTr("A Simple Text for Test")
        font.pixelSize: 12
    }
}
