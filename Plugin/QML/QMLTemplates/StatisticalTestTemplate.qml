import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Shapes 1.12

Rectangle
{
    id: root
    width: 500
    height: 545
    radius: 4
    color: "#060716"

    property alias distColor : distributionShapePath.strokeColor;
    property alias statisticalTestAnimationLabel : getTestStatisticButton.text;
    readonly property color backgroundColor: "#1a1a1a";
    readonly property color bridgeRailingColor: "#a6b0cb";
    readonly property color bridgeMiddle: "#ff333333";
    readonly property color gridLabelsColor: "#a6b0cb";
    property double alphaRectMoveX: 0.0;
    property bool showLabelsTopPlot : true;


    Rectangle
    {
        id: topBackgroundRect
        radius: 3
        color: backgroundColor
        width: parent.width
        height: 256

        Image
        {
            id: topBackgroundImage
            x: 20
            y: 0
            width: 460
            height: 237
            source: "qrc:/Images/MeanGrid.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    TextInput
    {
        id: lowInput
        validator: DoubleValidator{}
        y: 235
        x: 20 + 5 - width/2
        text: idea.xLowData.toPrecision(3)
        color: gridLabelsColor
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setXLowData(lowInput.text);
        }
        visible: showLabelsTopPlot
    }

    Text
    {
        y: 235
        x: 82.5 + 50 + 5 -width/2
        text: (0.75*idea.xLowData + 0.25*idea.xHighData).toPrecision(3)
        color: gridLabelsColor
        visible: showLabelsTopPlot

    }

    Text
    {
        y: 235
        x: 195 + 50 + 5 -width/2
        text: (0.5*idea.xLowData + 0.5*idea.xHighData).toPrecision(3)
        color: gridLabelsColor
        visible: showLabelsTopPlot

    }

    Text
    {
        y: 235
        x: 307.5 + 50 + 5 -width/2
        text: (0.25*idea.xLowData + 0.75*idea.xHighData).toPrecision(3)
        color: gridLabelsColor
        visible: showLabelsTopPlot

    }

    TextInput
    {
        id: upInput
        y: 235
        x: 420 + 50 + 5  -width/2
        text: idea.xHighData.toPrecision(3)
        color: gridLabelsColor
        validator: DoubleValidator{}
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setXHighData(upInput.text);
        }
        visible: showLabelsTopPlot

    }


    Rectangle
    {
        id: dataDisplayControlsRectangle
        width: 180
        height: 30
        x: 10
        y: 252
        radius: 3
        color: backgroundColor

        Button
        {
            id: getTestStatisticButton
            x: 5
            height: 32
            anchors.verticalCenter: parent.verticalCenter
            text: "Animate"
            onClicked:
            {
                if(idea.valid)
                    dataDisplayAnimation.start();
            }

            Material.background: idea.outPortLabelColors[0]
            Material.foreground:  "#1a1a1a"
            font.capitalization: Font.MixedCase
            ToolTip.delay: 1000;
            ToolTip.timeout: 5000;
            ToolTip.visible: hovered
            ToolTip.text: "Play the data animation.";
        }

        CheckBox
        {
            id: autoFitDataCheckbox
            anchors.right: parent.right
            anchors.rightMargin: 0
            text: "AutoFit"
            anchors.verticalCenter: parent.verticalCenter
            height: 40
            checked: idea.autoFitData;
            onCheckedChanged:
            {
                idea.setAutoFitData(checked);
            }
            Material.accent: "#a6b0cb"
            Material.foreground: "#a6b0cb"
        }
    }


    Rectangle
    {
        id: bottomBackgroundRect
        radius: 3
        color: backgroundColor
        width: parent.width
        y: 288
        height: 192

        Image
        {
            x: 20
            y: 2
            width: 460
            height: 162
            source: "qrc:/Images/DistributionBackground.png"
            fillMode: Image.PreserveAspectFit

            Shape
            {
                id: testStatisticDistributionShape
                opacity: 1.0
                width: 450
                height: 150
                x: 5
                y: 6
                visible: idea.valid

                ShapePath
                {
                    id: distributionShapePath
                    fillColor: "transparent"
                    strokeColor: idea.inPortLabelColors[1];
                    strokeWidth: 2
                    startX: 0
                    startY: 100
                }
            }
            Connections
            {
                target: idea
                function onPlotDistribution(xValues, yValues)
                {
                    distributionShapePath.pathElements = [];
                    var i;
                    distributionShapePath.startX = xValues[0]
                    distributionShapePath.startY = yValues[0]
                    for(i = 1; i < xValues.length; i++)
                    {
                        var pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                                          distributionShapePath);
                        pathLine.x = xValues[i];
                        pathLine.y = yValues[i];
                        distributionShapePath.pathElements.push(pathLine)
                    }
                }
            }
        }
    }

    TextInput
    {
        id: lowDistInput
        validator: DoubleValidator{}
        y: 460
        x: 20 + 5 - width/2
        text: idea.xLowDist.toPrecision(3)
        color: gridLabelsColor
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setXLowDist(lowDistInput.text);
        }
    }

    Text
    {
        y: 460
        x: 82.5 + 50 + 5 -width/2
        text: (0.75*idea.xLowDist + 0.25*idea.xHighDist).toPrecision(3)
        color: gridLabelsColor
    }

    Text
    {
        y: 460
        x: 195 + 50 + 5 -width/2
        text: (0.5*idea.xLowDist + 0.5*idea.xHighDist).toPrecision(3)
        color: gridLabelsColor
    }

    Text
    {
        y: 460
        x: 307.5 + 50 + 5 -width/2
        text: (0.25*idea.xLowDist + 0.75*idea.xHighDist).toPrecision(3)
        color: gridLabelsColor
    }

    TextInput
    {
        id: upDistInput
        y: 460
        x: 420 + 50 + 5  -width/2
        text: idea.xHighDist.toPrecision(3)
        color: gridLabelsColor
        validator: DoubleValidator{}
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setXHighDist(upDistInput.text);
        }
    }

    function prepareForAnimation(xPosPValueRect)
    {
        rejectText.opacity = 0.0;
        retainText.opacity = 0.0;
        pValueRectangle.opacity = 0.0;
        pValueRectangle.y = -30
        pValueRectangle.x = xPosPValueRect - pValueRectangle.width / 2

        summaryStatementTextHolderRectangle.opacity = 0.0;
    }

    function hideTestStatisticDistribution()
    {
        testStatisticDistributionShape.opacity = 0.0;
    }

    function fadeInTestStatisticDistribution()
    {
        fadeInTestStatisticAnimation.start();
    }
    PropertyAnimation
    {
        id: fadeInTestStatisticAnimation
        target: testStatisticDistributionShape; property: "opacity"; to: 1.0; duration: 2200 * idea.animationSpeed;
    }

    function highlightAlphaAnimation(alphaX)
    {
        root.alphaRectMoveX = alphaX;

        highlightAlphaParallelAnimation.start();
    }
    ParallelAnimation
    {
        id: highlightAlphaParallelAnimation
        PropertyAnimation{target: alphaHighlightRectangle; property: "color";
            duration: 300* idea.animationSpeed; to: idea.alphaColor;}
        PropertyAnimation{targets: [alphaTextInput, alphaText]; property: "color";
            duration: 300* idea.animationSpeed; to: "black";}
        PropertyAnimation{target: alphaRectangle; property: "x"; duration: 300* idea.animationSpeed; to: root.alphaRectMoveX;}
        PropertyAnimation{target: alphaRectangle; property: "y"; duration: 300* idea.animationSpeed; to: -30;}
    }
    function resetAlphaAnimation()
    {
        resetAlphaParallelAnimation.start();
    }

    ParallelAnimation
    {
        id: resetAlphaParallelAnimation
        PropertyAnimation{target: alphaHighlightRectangle; property: "color"; duration: 300* idea.animationSpeed; to: "transparent";}
        PropertyAnimation{targets: [alphaTextInput, alphaText]; property: "color"; duration: 300* idea.animationSpeed; to: idea.alphaColor;}
        PropertyAnimation{target: alphaRectangle; property: "x"; duration: 300* idea.animationSpeed; to: 230;}
        PropertyAnimation{target: alphaRectangle; property: "y"; duration: 300* idea.animationSpeed; to: 0;}
    }

    function finishPValueAnimation()
    {
        finishPValueSequentialAnimation.start();
    }

    SequentialAnimation
    {
        id: finishPValueSequentialAnimation

        ParallelAnimation
        {
            PropertyAnimation{target: pValueRectangle; property: "opacity"; duration: 300* idea.animationSpeed; to: 1.0}
            PropertyAnimation{target: pValueHighlightRectangle; property: "color"; duration: 300* idea.animationSpeed; to: idea.outPortLabelColors[1];}
            PropertyAnimation{targets: [pValueText, pValueTextInput]; property: "color"; duration: 300* idea.animationSpeed; to: "black";}
        }

        PauseAnimation {duration: 400 * idea.animationSpeed;}

        ParallelAnimation
        {
            PropertyAnimation{target: pValueRectangle; property: "y"; duration: 1200* idea.animationSpeed; to: 0}
            PropertyAnimation{target: pValueRectangle; property: "x"; duration: 1200* idea.animationSpeed; to: 360}
        }
        PauseAnimation {duration: 100 * idea.animationSpeed;}

        ParallelAnimation
        {
            PropertyAnimation{target: alphaHighlightRectangle; property: "color"; duration: 300* idea.animationSpeed; to: idea.alphaColor;}
            PropertyAnimation{targets: [alphaTextInput, alphaText]; property: "color"; duration: 300* idea.animationSpeed; to: "black";}
        }

        PauseAnimation {duration: 200*idea.animationSpeed}
        PropertyAnimation{target: summaryStatementTextHolderRectangle; property: "opacity"; to: 1.0; duration: 500* idea.animationSpeed;}
        PauseAnimation {duration: 200*idea.animationSpeed}

        ParallelAnimation
        {
            PropertyAnimation{target: alphaHighlightRectangle; property: "color"; duration: 300* idea.animationSpeed; to: "transparent";}
            PropertyAnimation{targets: [alphaTextInput, alphaText]; property: "color"; duration: 300* idea.animationSpeed; to: idea.alphaColor;}
            PropertyAnimation{target: pValueHighlightRectangle; property: "color"; duration: 300* idea.animationSpeed; to: "transparent";}
            PropertyAnimation{targets: [pValueText, pValueTextInput]; property: "color"; duration: 300* idea.animationSpeed; to: idea.outPortLabelColors[1];}
        }

        PauseAnimation {duration: 600*idea.animationSpeed}
        PropertyAnimation{targets: [retainText, rejectText]; property: "opacity"; to: 1.0; duration: 2200 * idea.animationSpeed;}
    }

    function fillArea(xValues, yValues, shapePath)
    {
        shapePath.pathElements = [];
        var i;  var pathLine;

        //Annoying edge case. Need to get rid of old plots.
        if(xValues.length === 0)
        {
            shapePath.startX = 0;
            shapePath.startY = 150;
            pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                          shapePath);
            pathLine.x = 0;
            pathLine.y = 150;
            shapePath.pathElements.push(pathLine)
            return;
        }

        //Start in the correct place
        shapePath.startX = xValues[0];
        shapePath.startY = 150;

        //Loop throught the values sent.
        for(i = 0; i < xValues.length; i++)
        {
            pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                          shapePath);
            pathLine.x = xValues[i];
            pathLine.y = yValues[i];
            shapePath.pathElements.push(pathLine)
        }
        //Drop down to zero from last point.
        pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                      shapePath);
        pathLine.x = xValues[xValues.length -1];
        pathLine.y = 150;
        shapePath.pathElements.push(pathLine)

        //Add the first point again.
        pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                      shapePath);
        pathLine.x = xValues[0];
        pathLine.y = 150;
        shapePath.pathElements.push(pathLine)
    }

    Item
    {
        id: bottomBar
        width: parent.width
        anchors.bottom: parent.bottom
        height: 67

        Rectangle
        {
            id: distributionDisplayControlsRectangle
            width: 180
            height: 30
            x: 10
            y: -1
            radius: 3
            color: backgroundColor

            Button
            {
                id: playTestStatisticsAnimationButton
                x: 5
                height: 32
                anchors.verticalCenter: parent.verticalCenter
                text: "Get p"
                onClicked:
                {
                    if(idea.valid)
                        testStatisticAnimation.start();
                }

                Material.background: idea.outPortLabelColors[1]
                Material.foreground:  "#1a1a1a"
                font.capitalization: Font.MixedCase
                ToolTip.delay: 1000;
                ToolTip.timeout: 5000;
                ToolTip.visible: hovered
                ToolTip.text: "Play the statistical test animation.";
            }

            CheckBox
            {
                anchors.right: parent.right
                anchors.rightMargin: 0
                text: "AutoFit"
                anchors.verticalCenter: parent.verticalCenter
                height: 40
                checked: idea.autoFitDist;
                onCheckedChanged:
                {
                    idea.setAutoFitDist(checked);
                }
                Material.accent: "#a6b0cb"
                Material.foreground: "#a6b0cb"
            }
        }

        Rectangle
        {
            id: alphaRectangle
            height: 36
            width: alphaText.width + alphaTextInput.width + 16;
            x: 230
            z: 2
            gradient: Gradient
            {
                GradientStop{position: 0.0; color: backgroundColor}
                GradientStop{position: 0.2; color: bridgeMiddle}
                GradientStop{position: 0.8; color: bridgeMiddle}
                GradientStop{position: 1.0; color: backgroundColor}
            }

            Rectangle
            {
                id: alphaHighlightRectangle
                color: "transparent"
                anchors.fill: parent
            }

            MouseArea
            {
                id: alphaMouseArea
                anchors.fill: parent
                hoverEnabled: true;
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked:
                {
                    if(mouse.button === Qt.RightButton)
                        idea.cycleAlphaColor();
                }
            }

            BridgeRailings{}

            Label
            {
                id: alphaText
                x: 8
                anchors.verticalCenter: parent.verticalCenter
                text: "\u03b1:";
                color: idea.alphaColor
                font.pointSize: 12

                ToolTip.delay: 1000;
                ToolTip.timeout: 5000;
                ToolTip.visible: alphaMouseArea.containsMouse;
                ToolTip.text: "False Positive Frequency";
            }
            TextInput
            {
                id: alphaTextInput
                anchors.left: alphaText.right
                anchors.verticalCenter: parent.verticalCenter
                text: idea.alpha
                font.underline: true;
                font.pointSize: 12
                color: idea.alphaColor
                selectByMouse: true;
                validator: DoubleValidator{bottom: 0.0; top: 1.0}
                onEditingFinished:
                {
                    idea.setAlpha(text);
                }
            }
        }
        Rectangle
        {
            id: pValueRectangle
            height: 36
            width: pValueText.width + pValueTextInput.width + 16
            x: 360
            z: 20
            visible: idea.valid;
            gradient: Gradient
            {
                GradientStop{position: 0.0; color: backgroundColor}
                GradientStop{position: 0.2; color: bridgeMiddle}
                GradientStop{position: 0.8; color: bridgeMiddle}
                GradientStop{position: 1.0; color: backgroundColor}
            }

            Rectangle
            {
                id: pValueHighlightRectangle
                color: "transparent"
                anchors.fill: parent
            }

            MouseArea
            {
                id: pValueMouseArea
                anchors.fill: parent
                hoverEnabled: true;
            }

            BridgeRailings{}

            Label
            {
                id: pValueText
                x: 8
                anchors.verticalCenter: parent.verticalCenter
                text: "p=";
                color: idea.outPortLabelColors[1]
                font.pointSize: 12

                ToolTip.delay: 1000;
                ToolTip.timeout: 5000;
                ToolTip.visible: pValueMouseArea.containsMouse;
                ToolTip.text: "Probability test results at least as extreme as observed. Assuming null is correct";
            }
            TextInput
            {
                id: pValueTextInput
                anchors.left: pValueText.right
                anchors.verticalCenter: parent.verticalCenter
                text: idea.pValue.toPrecision(2);
                font.pointSize: 12
                color: idea.outPortLabelColors[1]
                readOnly: true;
                selectByMouse: true;
            }
        }
        Rectangle
        {
            id: finalIsland
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: backgroundColor
            height: 33
            width: 330
            radius: 3

            Rectangle
            {
                id: summaryStatementRectangle
                width: 130
                height: 26
                x: 15
                radius: 3
                anchors.verticalCenter: parent.verticalCenter
                color: "#ff333333"

                Rectangle
                {
                    id: summaryStatementTextHolderRectangle
                    anchors.centerIn: parent
                    width: alphaInComparisonText.width + pLessOrGreaterText.width + 5
                    Text
                    {
                        id: pLessOrGreaterText
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: idea.pValue > idea.alpha ? "p >": "p <"
                        font.pointSize: 12
                        font.bold: true
                        visible: idea.valid
                        color: idea.outPortLabelColors[1]
                    }
                    Text
                    {
                        id: alphaInComparisonText
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: idea.alpha
                        font.pointSize: 12
                        font.bold: true
                        visible: idea.valid
                        color: idea.alphaColor
                    }
                }
            }

            Rectangle
            {
                id: retainRectangle
                height: 26
                width: 80
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 90
                radius: 3
                color: "#ff333333"

                Text
                {
                    id: retainText
                    x: 5
                    anchors.centerIn: parent
                    text: "Retain"
                    font.pointSize: 12
                    font.bold: true
                    visible: idea.valid
                    color: idea.pValue > idea.alpha ? idea.outPortLabelColors[1] : "#171717";
                }
            }

            Rectangle
            {
                id: rejectRectangle
                height: 26
                width: 80
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                radius: 3
                color: "#ff333333"
                Text
                {
                    id: rejectText
                    x: 5
                    anchors.centerIn: parent
                    text: "Reject"
                    font.pointSize: 12
                    font.bold: true
                    visible: idea.valid
                    color: idea.pValue > idea.alpha ? "#171717" : idea.outPortLabelColors[1];
                }
            }
        }
    }
}
