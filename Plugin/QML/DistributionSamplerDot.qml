import QtQuick 2.15

Rectangle
{
    id: root
    width: 12
    height: 12
    radius: 6
    opacity: 0.7

    property color finalColor: "#ffffff"
    property point finalPosition: Qt.point(0,0);

    SequentialAnimation
    {
        id: animation
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "x"
                to: finalPosition.x
                duration: 4000 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: root
                property: "y"
                to: finalPosition.y
                easing.type: Easing.InQuad
                duration: 4000 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: root
                properties: "width,height"
                to: 6
                easing.type: Easing.InQuad
                duration: 3000 * idea.animationSpeed
            }
            PropertyAnimation
            {
                target: root
                property: "color"
                to: finalColor
                duration: 4000 * idea.animationSpeed
            }
        }
    }

    function startAnimation()
    {
        animation.start();
    }
}
