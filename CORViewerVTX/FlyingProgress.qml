import QtQuick 2.0

Item {
    id: root
    property string flyName: "VCM-01 HEAVY TEST FLIGHT"
    property int lineWidth: 10
    property int nameWidth: 350
    property string colorBackground: "black"
    property string colorFont: "white"
    Canvas {
        id: canvas
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            ctx.beginPath()
            ctx.strokeStyle = root.colorBackground
            ctx.moveTo(0,0)
            ctx.lineTo(0,0)
            ctx.lineTo(nameWidth,0)
            ctx.lineTo(nameWidth+10,20)
            ctx.lineTo(width-nameWidth,20)
            ctx.lineTo(width-nameWidth+5,30)
            ctx.lineTo(width,30)
            ctx.lineTo(width,height)
            ctx.lineTo(0,height)
            ctx.lineTo(0,0)
            ctx.closePath()
            ctx.fill()
            ctx.fillStyle = root.colorFont
            var fontSize = Math.round(lineWidth*2)
            ctx.font = "bold " + fontSize +"px Unknown Font, sans-serif";
            ctx.fillText(flyName,0 + fontSize,fontSize);
        }
    }
    Image {
        id: imgLogo
        source: "qrc:/GUI/logo/VTX_logo.png"
        anchors.right: parent.right
        anchors.rightMargin: parent.height/2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        height: parent.height / 2
        width: sourceSize.width * 2 / sourceSize.height * height
    }
}
