import QtQuick

Rectangle {
    id: root
    color: "#000000"
    property int stage

    onStageChanged: {
        if (stage == 2) intro.start()
        if (stage == 5) settle.start()
    }

    Item {
        anchors.centerIn: parent
        width: 220; height: 300

        Image {
            id: mark
            source: "images/mark.svg"
            width: 120; height: 120
            sourceSize: Qt.size(240, 240)
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0
            scale: 0.92
            rotation: -120
        }

        Text {
            id: word
            text: "ODIVM"
            color: "#ffffff"
            font.family: "Unbounded"
            font.weight: Font.DemiBold
            font.pixelSize: 26
            font.letterSpacing: 26 * 0.24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: mark.bottom
            anchors.topMargin: 40
            opacity: 0
        }

        Text {
            text: "EX NIHILO, OMNIA."
            color: Qt.rgba(1, 1, 1, 0.35)
            font.family: "Geist Mono"
            font.weight: Font.Medium
            font.pixelSize: 11
            font.letterSpacing: 11 * 0.2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: word.bottom
            anchors.topMargin: 18
            opacity: word.opacity
        }
    }

    ParallelAnimation {
        id: intro
        NumberAnimation { target: mark; property: "opacity"; to: 1; duration: 900; easing.type: Easing.OutExpo }
        NumberAnimation { target: mark; property: "rotation"; to: 0; duration: 1400; easing.type: Easing.OutExpo }
        NumberAnimation { target: mark; property: "scale"; to: 1; duration: 1400; easing.type: Easing.OutExpo }
        SequentialAnimation {
            PauseAnimation { duration: 500 }
            NumberAnimation { target: word; property: "opacity"; to: 1; duration: 900; easing.type: Easing.OutExpo }
        }
    }

    NumberAnimation {
        id: settle
        target: mark; property: "rotation"; to: 60; duration: 900; easing.type: Easing.OutExpo
    }
}
