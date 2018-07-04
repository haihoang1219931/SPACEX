import QtQuick 2.0

Item {

  width: 640;
  height: 480
  Row {
      anchors.centerIn: parent; spacing: 10

      // Implements fading using Behavior
      Rectangle {
          id: fadingByBehavior

          width: 100; height: 100; color: "red"
          Behavior on opacity { PropertyAnimation { duration: 1000 } }

          MouseArea { anchors.fill: parent; onClicked: fadingByBehavior.opacity = 0.2 }
      }


      // Implements fading using States and Transitions
      Rectangle {
          id: fadingByState

          width: 100; height: 100; color: "green"

          MouseArea { anchors.fill: parent; onClicked: fadingByState.state = "hidden" }

          states: State { name: "hidden"; PropertyChanges { target: fadingByState; opacity: 0.2 } }

          transitions: Transition {
              from: "*"
              to: "hidden"
              PropertyAnimation { target: fadingByState; property: "opacity"; duration: 1000 }
          }
      }


      // Implements fading using animation as an element
      Rectangle {
          id: fadingByAnimationElement

          width: 100; height: 100; color: "blue"

          MouseArea { anchors.fill: parent; onClicked: hideAnimation.start() }

          PropertyAnimation {
              id: hideAnimation
              target: fadingByAnimationElement; property: "opacity"; to: 0.2; duration: 1000
          }
      }


      // Implements fading directly from the event handler
      Rectangle {
          id: fadingFromSignalHandler

          width: 100; height: 100; color: "yellow"

          MouseArea {
              anchors.fill: parent
              onClicked: PropertyAnimation {
                  target: fadingFromSignalHandler; property: "opacity"; to: 0.2; duration: 1000
              }
          }
      }
  }
}


