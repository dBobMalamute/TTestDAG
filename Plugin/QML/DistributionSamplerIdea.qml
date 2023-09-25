import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12

import com.malamute.distributions 1.0

SamplerTemplate
{
    id: root

    Item
    {
        id: dotsArea
        x: 55
        y: 10
        visible: idea.valid;
        width: 450
        height: 300

        property int numDotsShown: 0;
    }

    Connections
    {
        target: idea
        function onStartAnimation()
        {
            if(idea.totalSamples > dotsArea.numDotsShown)
                addDotAnimation.start();
        }
        function onResetAnimation()
        {
            addDotAnimation.stop();

            for(var j = 0; j < dotsArea.children.length; j++)
            {
                dotsArea.children[j].destroy();
            }
            dotsArea.numDotsShown = 0;
        }
    }

    SequentialAnimation
    {
        id: addDotAnimation;
        running: false;
        loops: Animation.Infinite

        ScriptAction
        {
            script: root.addNextDot();
        }
        PauseAnimation
        {
            duration: 200 * idea.animationSpeed;
        }
    }

    function addNextDot()
    {
        if(!idea.valid || dotsArea.numDotsShown >= idea.totalSamples)
            addDotAnimation.stop();
        else
        {
            let comp = Qt.createComponent("DistributionSamplerDot.qml");
            let pos = idea.getPositionForDot(dotsArea.numDotsShown);

            let baseColor = idea.outPortLabelColors[0];
            let tintColor = Qt.rgba(Math.random(1),
                                    Math.random(1),
                                    Math.random(1),
                                    0.4)

            let obj = comp.createObject(dotsArea,{x: dotsArea.numDotsShown % 2 * 450,
                                            color: idea.inPortLabelColors[0],
                                            finalColor: Qt.tint(baseColor, tintColor),
                                            finalPosition: pos});
//                        obj.x = pos.x  - 2;
//                        obj.y = pos.y;
            obj.startAnimation();
            dotsArea.numDotsShown++;
        }
    }
}
