import QtQuick 2.12

Rectangle
{
    id: tValueBar
    property double delay: 0.0
    property color primaryColor: "black"

    width: 16
    y: (-height / 2) + 8
    opacity: 0.0
    radius: 2

    rotation: 90;
    transformOrigin: Item.Center

    gradient: Gradient
    {
        GradientStop{position: 0.0; color: "black"}
        GradientStop{position: 0.5; color: primaryColor}
    }

    function startAnimating()
    {
        animation.start()
    }

    SequentialAnimation
    {
        id: animation
        PauseAnimation
        {
            duration: 800*idea.animationSpeed * delay
        }
        NumberAnimation
        {
            target: tValueBar
            property: "opacity"
            duration: 1000*idea.animationSpeed
            to: 1.0
        }
    }
}
