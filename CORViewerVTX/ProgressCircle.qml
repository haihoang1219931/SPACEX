import QtQuick 2.0
import QtQml 2.2

Item {
    id: root

    width: size
    height: size*8/10

    property int size: 200               // The size of the circle in pixel
    property real arcBegin: 0            // start arc angle in degree
    property real arcEnd: 270            // end arc angle in degree
    property real arcOffset: 0           // rotation
    property bool isPie: false           // paint a pie instead of an arc
    property bool showBackground: false  // a full circle as a background of the arc
    property real lineWidth: 20          // width of the line
    property string colorCircle: "#CC3333"
    property string colorBackground: "#80171717"
    property string colorFont: "white"
    property string unit: ""
    property int value: 0
    property int valueMax: 1
    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 200

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    function updateValue(newValue){
        value = newValue;
        canvas.requestPaint();
        boundary.requestPaint();
    }

    Behavior on arcBegin {
       id: animationArcBegin
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
           duration: root.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Rectangle{
        anchors.fill: parent
        color: colorBackground

    }
    Canvas {
        id: canvas
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: size * 60 /100
        height: size * 60 /100

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var closeEnd = Math.PI * ((parent.arcEnd - 30)/ 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            if (root.isPie) {
                if (root.showBackground) {
                    ctx.beginPath()
                    ctx.fillStyle = root.colorBackground
                    ctx.moveTo(x, y)
                    ctx.arc(x, y, width / 2, 0, Math.PI * 2, false)
                    ctx.lineTo(x, y)
                    ctx.fill()
                }
                ctx.beginPath()
                ctx.fillStyle = root.colorCircle
                ctx.moveTo(x, y)
                ctx.arc(x, y, width / 2, start, end, false)
                ctx.lineTo(x, y)
                ctx.fill()
            } else {
                if (root.showBackground) {
                    ctx.beginPath();
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                    ctx.lineWidth = root.lineWidth
                    ctx.strokeStyle = root.colorBackground
                    ctx.stroke()
                }
                ctx.beginPath();
                ctx.lineWidth = root.lineWidth
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, closeEnd, false)
                ctx.strokeStyle = "gray"
                ctx.stroke()
                ctx.beginPath()
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, closeEnd, end, false)
                ctx.strokeStyle = "darkred"
                ctx.stroke()
                ctx.beginPath()
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, start+(value/valueMax)*(end-start), false)
                ctx.strokeStyle = "#66FFFFFF"
                ctx.stroke()
            }
        }
    }
    Canvas {
        id: boundary
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.beginPath()
            ctx.strokeStyle = "lightgray"
            ctx.lineWidth = 2
            ctx.moveTo(0,0)
            ctx.lineTo(0,0)
            ctx.lineTo(0, height)
            ctx.lineTo(width, height)
            ctx.lineTo(width, 0)
            ctx.closePath()
            ctx.stroke()
            // draw unit

            ctx.fillStyle = root.colorFont
            var fontSize = Math.round(lineWidth*2)
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText(unit,width/2 + fontSize,height*8/10);
            fontSize = Math.round(lineWidth*3)
            ctx.font = "" + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText(Number(value).toString(),width/2 - fontSize+3,height / 2 + fontSize / 2);
        }
    }

    Canvas {
        id: rectBottomRight
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width/3
        height: lineWidth
        onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = "lightgray"
            ctx.beginPath()
            ctx.moveTo(height, 0)
            ctx.lineTo(width, 0)
            ctx.lineTo(width, height)
            ctx.lineTo(0, height)
            ctx.lineTo(height,0)
            ctx.closePath()
            ctx.fill()

        }
    }
}
