import QtQuick 2.12

Item
{
    id: root
    width: 450;
    height: 200;

    property double dotX : 0;
    property double dotInitialY : 0;
    property double squareFinalY: 0
    property double lineDistance: 0;
    property double barX: 0;
    property bool rightSideOfMean: true;

    property double meanPosition: 0;
    property double stdevLength: 0;
    property double pauseFrac: 0.0;
    property color dotColor: "black";

    function startAnimation(yValue)
    {
        dot.width = 16;
        dot.height = 16;
        dot.x = -40
        dot.y = yValue
        bar.width = 1;
        bar.x = dotX;
        bar.opacity = 0.4;
        square.width = 1;
        square.height = 1;
        square.x = dotX;
        square.y = 199;
        animation.start();
    }

    function moveUp()
    {
        moveUpAnimation.start();
    }
    NumberAnimation
    {
        id: moveUpAnimation;
        target: dot
        property: "y"
        to: dotInitialY - 3
        duration: 300* idea.animationSpeed
    }

    Rectangle
    {
        id: dot
        width: 6
        height: 6
        radius: 8
        x: dotX - 3;
        y: dotInitialY-3

        color: dotColor
    }

    Rectangle
    {
        id: bar;
        y: dotInitialY-1
        height: 2;
        width: 1
        x: dotX;
        color: dot.color;
        opacity: 0.4
    }

    Rectangle
    {
        id: square;
        height: 1;
        width: 1
        x: dotX;
        y: 199;
        color: "transparent";
        border.color: dot.color
        border.width: 1
        opacity: 0.0
    }

    SequentialAnimation
    {
        id: animation
        running: false;
        PauseAnimation
        {
            duration: 2000 * pauseFrac * idea.animationSpeed
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: dot
                properties: "width,height"
                to: 6
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: dot
                property: "x"
                to: dotX - 3
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: dot
                property: "y"
                to: dotInitialY - 3
                duration: 1400 * idea.animationSpeed
                easing.type: Easing.OutBounce
            }
        }
        PauseAnimation
        {
            duration: 2000 * (1.0 - pauseFrac) * idea.animationSpeed
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: bar
                property: "width"
                to: lineDistance
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: bar
                property: "x"
                to: dotX + barX
                duration: 1400 * idea.animationSpeed
            }
        }
        PauseAnimation
        {
            duration: 200 * idea.animationSpeed
        }
        NumberAnimation
        {
            target: bar
            property: "opacity"
            to: 0.0
            duration: 800*idea.animationSpeed
        }
        PauseAnimation
        {
            duration: 200 * idea.animationSpeed
        }

        NumberAnimation
        {
            target: dot
            property: "y"
            to: 200 - 3;
            duration: 1000*idea.animationSpeed
            easing.type: Easing.OutQuad
        }
        PropertyAction
        {
            target: square
            property: "opacity"
            value: 0.7;
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: square
                property: "x"
                to: meanPosition > dotX ? dotX : meanPosition;
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: square
                property: "y"
                to: 200 - lineDistance;
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: square
                properties: "width,height"
                to: lineDistance;
                duration: 1400 * idea.animationSpeed
            }
        }
        ParallelAnimation
        {
            NumberAnimation
            {
                target: square
                property: "x"
                to: rightSideOfMean ? meanPosition + (stdevLength - lineDistance) / 2 :
                                      meanPosition + (stdevLength - lineDistance) / 2 - stdevLength;
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: square
                property: "y"
                to: squareFinalY + stdevLength / 2 - lineDistance / 2;
                duration: 1400 * idea.animationSpeed
            }
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: square
                property: "x"
                to: rightSideOfMean ? meanPosition : meanPosition - stdevLength;
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: square
                property: "y"
                to: squareFinalY;
                duration: 1400 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: square
                properties: "width,height"
                to: stdevLength;
                duration: 1400 * idea.animationSpeed
            }
        }
        PauseAnimation
        {
            duration: 1000 * idea.animationSpeed
        }
        NumberAnimation
        {
            target: square
            property: "opacity"
            to: 0
            duration: 200 * idea.animationSpeed
        }
    }
}


