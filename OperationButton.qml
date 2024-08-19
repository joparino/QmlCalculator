import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

RoundButton {
    id: button
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.maximumWidth: 60
    Layout.maximumHeight: 60

    icon.source: modelData.icon

    padding: 0

    contentItem: Item {
        Image {
            anchors.centerIn: parent
            source: button.icon.source
        }
    }


    background: Rectangle {
        radius: 360
        color: button.pressed ? colors.accentOperationColor : colors.defaultOperationColor
    }
}
