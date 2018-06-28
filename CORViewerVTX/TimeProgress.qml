import QtQuick 2.0
import "JS/stringFormat.js" as Conv
Item {
    id: root
    width: 300
    height: 40
    property string currStage: "STAGE 1"
    property string currSignal: "TELEMETRY"
    property string currTime: "00:00:00"
    property string colorBackground: "#80171717"
    property string colorFont: "white"

    function updateData(newTime,newSpeed,newAltitude){
        var second = Number(newTime / 1000).toFixed(0);
        var minute = Number(second / 60 ).toFixed(0);
        var hour = Number(minute / 1000 / 60 / 60).toFixed(0);;

        currTime=Conv.pad(hour,2)+":"+Conv.pad(minute%60,2)+":"+Conv.pad(second%60,2);
        cvTime.requestPaint();
        speedProgress.updateValue(newSpeed);
        altitudeProgress.updateValue(newAltitude);
    }

    Canvas {
        id: cvTime
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: parent.width + parent.height
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.fillStyle = "steelblue"
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(width,0)
            ctx.lineTo(width,height)
            ctx.lineTo(height,height)
            ctx.lineTo(0,0)
            ctx.closePath()
            ctx.fill()
            ctx.fillStyle = root.colorFont
            var fontSize = Math.round(height*7/10)
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText("T+",fontSize*1.5,height*2/3);
            ctx.fillText(currTime,fontSize * 3 + fontSize,height*2/3);

        }
    }
    Canvas {
        id: cvInformation
        anchors.right: parent.right
        anchors.top: cvTime.bottom
        anchors.topMargin: 2
        height: parent.height
        width: parent.width
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.fillStyle = root.colorBackground
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(width,0)
            ctx.lineTo(width,height)
            ctx.lineTo(0,height)
            ctx.lineTo(0,0)
            ctx.closePath()
            ctx.fill()
            ctx.fillStyle = root.colorFont
            var fontSize = Math.round(height*5/10)
            ctx.font = "bold " + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText(currStage,fontSize,height*2/3);
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText(currSignal,width/2 ,height*2/3);
        }
    }

    Canvas {
        id: cvHeader
        anchors.right: parent.right
        anchors.top: cvInformation.bottom
        anchors.topMargin: 2
        height: parent.height*3/5
        width: parent.width
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.fillStyle = root.colorBackground
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(width,0)
            ctx.lineTo(width,height)
            ctx.lineTo(0,height)
            ctx.lineTo(0,0)
            ctx.closePath()
            ctx.fill()
            ctx.fillStyle = root.colorFont
            var fontSize = Math.round(height*7/10)
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText("SPEED",fontSize,height*2/3);
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText("ALTITUDE",width/2 ,height*2/3);
        }
    }
    Row{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: cvHeader.bottom
        anchors.topMargin: 2
        height: 200
        ProgressCircle {
            id: speedProgress
            size: parent.width/2
            arcBegin: 90
            arcEnd: 340
            lineWidth: 7
            unit: "km/h"
            value: 0
            valueMax: 20000
        }
        ProgressCircle {
            id: altitudeProgress
            size: parent.width/2
            arcBegin: 90
            arcEnd: 340
            lineWidth: 7
            value: 0
            valueMax: 200
            unit: "km"
        }
    }

}
