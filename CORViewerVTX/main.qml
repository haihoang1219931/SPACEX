import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1376
    height: 758
    title: qsTr("Hello World")
    property real speed: 0
    property real altitude: 0
    property real speedMax: 20000
    property real altitudeMax: 200
    property real dSpeed: 3
    property real dAltitude: 0.1
    property int time: 0
    property int dTime: 30
    Image{
        id: background
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/GUI/background/digitalmap.jpg"
        focus: true
        Keys.onPressed:{
            if(event.key === Qt.Key_Space){

                timeProgress.hideInfo();
                console.log("timeProgress.hiding="+timeProgress.hiding);
            }
        }
    }

    Rectangle {
        id: rectangle
        x: 78
        y: 101
        width: 592
        height: 523
        color: "#383535"
    }


    FlyingProgress {
        id: flyingProgress
        y: 945
        height: 80
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }


    Rectangle {
        id: rectangle1
        x: 695
        y: 101
        width: 592
        height: 523
        color: "#383535"
    }

    TimeProgress {
        id: timeProgress
        width: 300
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 4
    }
    Timer{
        interval: dTime; running: true; repeat: true
        onTriggered: {
            var date = new Date();
            speed+=dSpeed;
            altitude+=dAltitude;
            time+=dTime;
            if(speed > speedMax){
                speed = speedMax
                dSpeed = -Math.abs(dSpeed);
            }
            if(speed < 0){
                speed = 0
                dSpeed = Math.abs(dSpeed);
            }

            if(altitude > altitudeMax){
                altitude = altitudeMax
                dAltitude = -Math.abs(dAltitude);
            }
            if(altitude < 0){
                altitude = 0
                dAltitude = Math.abs(dAltitude);
            }
            timeProgress.updateData(time,speed,altitude);
        }
    }
}
