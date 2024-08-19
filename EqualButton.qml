import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

DelayButton {
    id: delayButton
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.maximumWidth: 60
    Layout.maximumHeight: 60
    delay: 4000

    icon.source: "qrc:/assets/equal.svg"

    padding: 0

    contentItem: Item {
        Image {
            anchors.centerIn: parent
            source: delayButton.icon.source
        }
    }

    background: Rectangle {
        radius: 360
        color: delayButton.pressed ? colors.accentOperationColor : colors.defaultOperationColor
    }
}
