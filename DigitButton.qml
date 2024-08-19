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
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        height: 30
        text: modelData.text
        font.pixelSize: 24
        font.family: "Open Sans"
        font.weight: Font.DemiBold
        font.letterSpacing:  1
        color:
            switch(modelData.type) {
                case "clear":
                    return colors.white
                default:
                    return digitButton.pressed ? colors.white : colors.defaultColor
            }
    }



    background: Rectangle {
        radius: 360
        color:
            switch(modelData.type) {
                case "clear":
                    return digitButton.pressed ? colors.accentClearColor : colors.defaultClearColor
                default:
                    return digitButton.pressed ? colors.accentDigitColor : colors.defaultDigitColor
            }
    }
}

