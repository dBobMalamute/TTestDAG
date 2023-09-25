import QtQuick 2.0

Item
{
    id: root
    property double lineDistance: 0;
    property point dotPos: Qt.point(0,0)
    property double pauseFrac: 0.0;
    property color dotColor : "black"
    property color meanColor: "black"

    x: -30;
    y: 140

    Rectangle
    {
        id: dot
        width: 12
        height: 12
        radius: 6
        x: - 3;
        y: -3;
        color: dotColor
    }

    Rectangle
    {
        id: bar;
        y: - height / 2;
        x: lineDistance > 0 ? height / 2 : - height / 2 - 4
        height: 1;
        width: 4
        color: dot.color;
        opacity: 0.0
        rotation: lineDistance > 0 ? 270 : 90
        transformOrigin: Item.Center
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: dotColor}
            GradientStop{position: 1.0; color: meanColor}
        }
    }

    SequentialAnimation
    {
        id: animation
        running: true
        PauseAnimation
        {
            duration: 2000 * pauseFrac * idea.animationSpeed
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: root
                property: "x"
                to: dotPos.x
                duration: 1700 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: root
                property: "y"
                to: dotPos.y
                duration: 1700 * idea.animationSpeed
                easing.type: Easing.OutBounce
            }
            NumberAnimation
            {
                target: dot
                properties: "width,height"
                to: 6;
                duration: 1700 * idea.animationSpeed
            }
        }
        PauseAnimation
        {
            duration: 2000 * (1.0 - pauseFrac) * idea.animationSpeed
        }
        PropertyAction{target: bar; property: "opacity"; value: 0.4}

        NumberAnimation
        {
            target: bar
            property: "height"
            to: lineDistance > 0 ? lineDistance - 2 : -1.0*lineDistance - 2;
            duration: 3000 * idea.animationSpeed
        }

    }
}
