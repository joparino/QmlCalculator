import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15



Window {
    QtObject{
        id: colors
        readonly property string white: "#FFFFFF"

        readonly property string defaultColor: "#024873"
        readonly property string resultAreaColor: "#04BFAD"

        readonly property string defaultOperationColor: "#0889A6"
        readonly property string accentOperationColor: "#F7E425"

        readonly property string defaultDigitColor: "#B0D1D8"
        readonly property string accentDigitColor: colors.resultAreaColor

        readonly property string defaultClearColor: "#f9afaf"
        readonly property string accentClearColor: "#F25E5E"
    }

    id: window
    width: 360
    height: 620
    visible: true
    title: qsTr("QmlCalculator")
    color: colors.defaultColor

    property string expressionString
    property string historyString
    property bool isSolved
    property bool isBracketStart
    property double combinationStart
    property string combination: "123"

    function detectHoldEqual()
    {
        combinationStart = new Date().getSeconds()
    }

    function prepareExpression(symbol)
    {

        if (isSolved)
        {
            isSolved = false
            historyString += "=" + expressionString
            expressionString = ""
        }

        switch (symbol) {
        case "=":
            if (expressionString.length > 1)
            {
                historyString = expressionString
                expressionString = Calculator.evalute(expressionString)
                isSolved = true
            }
            break
        case "()":
            if (isBracketStart)
            {
                isBracketStart = false
                if (expressionString.slice(-1) === "(")
                {
                    expressionString += "0)"
                    break
                }
                expressionString += ")"
                break
            }
            isBracketStart = true
            expressionString += "("
            break
        case "%":
            expressionString += "*0.01"
            break
        case "+-":
            expressionString += "*(-1)"
            break
        case "C":
            expressionString = ""
            break
        default:
            expressionString += symbol
            break
        }

        if (new Date().getSeconds() <= combinationStart + 5)
        {
            if (expressionString === combination)
            {
                secretMenu.visible = true
            }
        }
    }

    Rectangle {
        id: secretMenu
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: colors.defaultColor
        visible: false

        Text {
            id: textSecretMenu
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 20
            font.family: "Open Sans"
            font.weight: Font.DemiBold
            font.letterSpacing:  0.5
            text: "Секретное меню"
            color: colors.white
        }

        Button {
            id: backToCalculatorButton
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 20
            font.family: "Open Sans"
            font.weight: Font.DemiBold
            font.letterSpacing:  0.5
            text: "Назад"
            onClicked: secretMenu.visible = false
        }
    }

    Rectangle {
        id: roundedResultArea
        height: parent.height / 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: colors.resultAreaColor
        radius: 20
        visible: secretMenu.visible ? false : true

        Rectangle {
            id: resultArea
            height: parent.height / 4
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            color: colors.resultAreaColor

            Text {
                id: historyText
                height: 30
                anchors.bottom: resultArea.bottom
                anchors.right: parent.right
                anchors.rightMargin: 24
                anchors.bottomMargin: resultText.font.pixelSize + 10
                color: colors.white
                text: historyString
                font.pixelSize: 20
                font.family: "Open Sans"
                font.weight: Font.DemiBold
                font.letterSpacing:  0.5
            }

            Text {
                id: resultText
                height: 60
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 24
                color: colors.white
                text: expressionString
                font.pixelSize: 50
                font.family: "Open Sans"
                font.weight: Font.DemiBold
                font.letterSpacing:  0.5
            }
        }
    }

    GridLayout  {
        id: buttons
        anchors.top: roundedResultArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        anchors.bottomMargin: 20
        rows: 5
        columns: 4
        columnSpacing: 24
        rowSpacing: 24
        visible: secretMenu.visible ? false : true


        Repeater {
            id:operationsInRow
            model:
                [{"type": "operation", "text": "()", "icon": "qrc:/assets/bkt.svg", "event": ("(")},
                {"type": "operation", "text": "+-", "icon": "qrc:/assets/plus_minus.svg"},
                {"type": "operation", "text": "%", "icon": "qrc:/assets/percent.svg"},
                {"type": "operation", "text": "/", "icon": "qrc:/assets/division.svg"}]
            delegate: OperationButton {
                Layout.row: 0
                Layout.column: index
                onClicked: prepareExpression(modelData.text)
            }
        }

        Repeater {
            id:operationsInColumn
            model:
                [{"type": "operation", "text": "*", "icon": "qrc:/assets/multiplication.svg"},
                {"type": "operation", "text": "-", "icon": "qrc:/assets/minus.svg"},
                {"type": "operation", "text": "+", "icon": "qrc:/assets/plus.svg"}]
            delegate: OperationButton {
                Layout.row: index + 1
                Layout.column: 3
                onClicked: prepareExpression(modelData.text)
            }
        }

        Repeater {
            id: digitInFirstRow
            model:
                [{"type": "digit", "text": "7", "icon": ""},
                {"type": "digit", "text": "8", "icon": ""},
                {"type": "digit", "text": "9", "icon": ""}]
            delegate: DigitButton {
                Layout.row: 1
                Layout.column: index
                onClicked: prepareExpression(modelData.text)
            }
        }

        Repeater {
            id: digitInSecondRow
            model:
                [{"type": "digit", "text": "4", "icon": ""},
                {"type": "digit", "text": "5", "icon": ""},
                {"type": "digit", "text": "6", "icon": ""}]
            delegate: DigitButton {
                Layout.row: 2
                Layout.column: index
                onClicked: prepareExpression(modelData.text)
            }
        }

        Repeater {
            id: digitInThirstRow
            model:
                [{"type": "digit", "text": "1", "icon": ""},
                {"type": "digit", "text": "2", "icon": ""},
                {"type": "digit", "text": "3", "icon": ""}]
            delegate: DigitButton {
                Layout.row: 3
                Layout.column: index
                onClicked: prepareExpression(modelData.text)
            }
        }

        Repeater {
            id: digitInFourRow
            model:
                [{"type": "clear", "text": "C", "icon": ""},
                {"type": "digit", "text": "0", "icon": ""},
                {"type": "digit", "text": ".", "icon": ""}]
            delegate: DigitButton {
                Layout.row: 4
                Layout.column: index
                onClicked: prepareExpression(modelData.text)
            }
        }

        EqualButton {
            Layout.row: 4
            Layout.column: 3
            onActivated: detectHoldEqual()
            onClicked: prepareExpression("=")
        }
    }
}
