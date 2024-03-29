// NOTE: New Component!
import QtQuick 2.12

import Lomiri.Components 1.3
import Lomiri.Components.ListItems 1.3

Page {
    id: page

    header: PageHeader {
        id: pageHeader
        title: tr.get("ShiftRhythm")

        leadingActionBar.actions: [
            Action {
                iconName: "back"
                onTriggered: {
                    page.save()
                    stack.pop()
                }
            }
        ]

        Button {
            anchors.right: parent.right
            anchors.rightMargin: units.gu(1)
            anchors.verticalCenter: parent.verticalCenter
            text: tr.get("ShiftConfig")
            onClicked: {
                page.save()
                stack.push(Qt.resolvedUrl("../edit-shifts/page.qml"))
            }
        }
    }

    function load() {
        stepsEditArea.text = ctxo.shiftHandler.stepsText
    }

    function save() {
        ctxo.shiftHandler.stepsText = stepsEditArea.text

        ctxo.shiftHandler.qmlParseSteps()
        for (let step of JSON.parse(ctxo.shiftHandler.qmlGetStepsArray())) {
            if (!ctxo.shiftHandler.shiftsConfig.exists(step)) {
                ctxo.shiftHandler.shiftsConfig.append(step, "", 0, false)
            }
        }
    }

    Rectangle {
        id: textAreaRect
        color: "transparent"
        anchors.top: parent.top
        anchors.topMargin: pageHeader.height + units.gu(0.5)
        anchors.right: parent.right
        anchors.rightMargin: units.gu(0.5)
        anchors.left: parent.left
        anchors.leftMargin: units.gu(0.5)
        height: parent.height - pageHeader.height - units.gu(1)
        clip: true

        TextArea {
            id: stepsEditArea
            anchors.fill: parent
            anchors.margins: units.gu(0.25)
            placeholderText: tr.get("CommaSeparatedString")
            font.family: "Fira Code"
        }
    }

    Connections {
        target: Qt.inputMethod

        onKeyboardRectangleChanged: {
            var newRect = Qt.inputMethod.keyboardRectangle
            textAreaRect.height = (parent.height - pageHeader.height - units.gu(1.0)) - newRect.height
        }
    }

    Connections {
        target: stack
        onCurrentPageChanged: {
            if (stack.currentPage === page) {
                page.load()
            }
        }
    }
}
