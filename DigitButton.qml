import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

RoundButton {
    id: digitButton
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.maximumWidth: 60
    Layout.maximumHeight: 60

    padding: 0

    contentItem: Text {
        anchors.fill: parent
        text: modelData.text
        font.pixelSize: 24
        font.family: "Open Sans Semibold"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color:
            switch(modelData.type) {
                case "clear":
                    return "#FFFFFF"
                default:
                    return digitButton.pressed ? "#FFFFFF" : "#024873"
            }
    }



    background: Rectangle {
        radius: 360
        color:
            switch(modelData.type) {
                case "clear":
                    return digitButton.pressed ? "#F25E5E" : "#f9afaf"
                default:
                    return digitButton.pressed ? "#04BFAD" : "#B0D1D8"
            }
    }
}

