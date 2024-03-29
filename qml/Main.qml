import QtQuick 2.12

import Lomiri.Components 1.3

MainView {
    width: units.gu(45)
    height: units.gu(75)

    applicationName: "shift-scheduler.knackwurstking"

    FontLoader {
        source: "../assets/fonts/FiraCode-VariableFont_wght.ttf"
    }

    PageStack {
        id: stack

        Component.onCompleted: {
            theme.name = ctxo.theme
            stack.push(Qt.resolvedUrl("./views/month/page.qml"))
        }
    }
}
