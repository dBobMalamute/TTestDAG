import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import com.malamute.numbers 1.0

StatisticTemplate
{
    Item
    {
        id: dotsArea
        x: 25
        y: 5
        width: 450
        height: 227
        visible: idea.valid
    }

    Connections
    {
        target: idea
        function onStartMeanAnimation(dotPositions, meanPosition)
        {
            onClearDisplay();

            meanLine.x = 24 + meanPosition;
            let i; let comp; let obj;
            let startY = 20;
            let YHeight = 185;

            if(dotPositions.length <= 2)
            {
                startY = 100;
                YHeight = 0;
            }
            else if(dotPositions.length <= 10)
            {
                startY = 125 - 10*dotPositions.length;
                YHeight = 20 * dotPositions.length;
            }

            //Add dots
            for(i = 0; i < dotPositions.length; i++)
            {
                let baseColor = idea.inPortLabelColors[0];
                let tintColor = Qt.rgba(Math.random(1), Math.random(1), Math.random(1), 0.4)

                comp = Qt.createComponent("NumbersMeanIdeaDot.qml");
                obj = comp.createObject(dotsArea,
                                        {dotPos: Qt.point(dotPositions[i],
                                                          startY + YHeight * (i / (dotPositions.length-1))),
                                            lineDistance: meanPosition - dotPositions[i],
                                            dotColor: Qt.tint(baseColor, tintColor),
                                            pauseFrac: i / (dotPositions.length - 1),
                                            meanColor: idea.outPortLabelColors[0]})
            }
            meanLine.startAnimating();
        }

        function onClearDisplay()
        {
            var i;
            meanLine.stopAnimating();
            for(i = 0; i < dotsArea.children.length; i++)
            {
                dotsArea.children[i].destroy();
            }
        }
    }

    Rectangle
    {
        id: meanLine
        visible: idea.valid;
        opacity: 0.0;
        width: 2;
        color: idea.outPortLabelColors[0]
        height: 210
        y: 20

        function startAnimating(delay)
        {
            meanLineAnimation.start();
        }
        function stopAnimating()
        {
            meanLineAnimation.stop();
            meanLine.opacity = 0.0;
        }

        RectangularGlow
        {
            id: effect
            x: 0
            y: 0
            width: parent.width
            height: parent.height

            glowRadius: 6
            spread: 0.4
            color: idea.outPortLabelColors[0]
            opacity: 0.1
        }

        Rectangle
        {
            id: meanText

            width: meanWords.width + 4
            height: meanWords.height + 4
            x: -width/ 2
            y: -17

            color: "black"
            border.width: 1
            border.color: "#1a1a1a"
            opacity: 1.0;
            Text
            {
                id: meanWords
                opacity: parent.opacity;
                anchors.centerIn: parent
                font.pointSize: 10
                font.bold: true

                text: "Average: " + idea.statistic.toPrecision(4);
                color: idea.outPortLabelColors[0]
            }
        }
        SequentialAnimation
        {
            id: meanLineAnimation

            PauseAnimation
            {
                duration: 6300 * idea.animationSpeed
            }
            NumberAnimation
            {
                target: meanLine
                property: "opacity"
                to: 1
                duration: 2000 * idea.animationSpeed
                easing.type: Easing.InOutQuad
            }
        }
    }
}
