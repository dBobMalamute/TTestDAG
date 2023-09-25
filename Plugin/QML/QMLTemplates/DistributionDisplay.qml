import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item
{
    id: root
    width: 530
    height: 370
    property real plotOpacity: 1.0;
    property alias distributionColor : plotShapePath.strokeColor

    Rectangle
    {
        width: 530
        height: 330
        radius: 4
        color: "#1a1a1a"
        border.width: 2
        border.color: "#333333"
    }

    property bool displayContinuous : false;

    Image
    {
        id: gridImage
        x: 50
        y: 5
        width: 460
        height: 310
        source: "qrc:/Images/GridLines.png"
    }

    TextInput
    {
        validator: DoubleValidator{}
        x: 47 - width
        y: 10 - height/2
        text: idea.yHigh.toPrecision(3);
        color: "#a6b0cb"
        selectByMouse: true
        font.underline: true
        onEditingFinished:
        {
            idea.setYHigh(text);
        }
    }
    Text
    {
        x: 47 - width
        y: 85 - height/2
        text: (0.75*idea.yHigh + 0.25*idea.yLow).toPrecision(3)
        color: "#a6b0cb"
    }
    Text
    {
        x: 47 - width
        y: 160 - height/2
        text: (0.5*idea.yHigh + 0.5*idea.yLow).toPrecision(3)
        color: "#a6b0cb"
    }
    Text
    {
        x: 47 - width
        y: 235 - height/2
        text: (0.25*idea.yHigh + 0.75*idea.yLow).toPrecision(3)
        color: "#a6b0cb"
    }
    TextInput
    {
        validator: DoubleValidator{}
        x: 47 - width
        y: 305 - height/2
        text: idea.yLow.toPrecision(3)
        color: "#a6b0cb"
        selectByMouse: true
        font.underline: true
        onEditingFinished:
        {
            idea.setYLow(text);
        }
    }
    TextInput
    {
        validator: DoubleValidator{}
        y: 313
        x: 50 + 5 - width/2
        text: idea.xLow.toPrecision(3)
        color: "#a6b0cb"
        selectByMouse: true
        font.underline: true
        onEditingFinished:
        {
            idea.setXLow(text);
        }
    }

    Text
    {
        y: 313
        x: 112.5 + 50 + 5 -width/2
        text: (0.75*idea.xLow + 0.25*idea.xHigh).toPrecision(3)
        color: "#a6b0cb"
    }

    Text
    {
        y: 313
        x: 225 + 50 + 5 -width/2
        text: (0.5*idea.xLow + 0.5*idea.xHigh).toPrecision(3)
        color: "#a6b0cb"
    }

    Text
    {
        y: 313
        x: 337.5 + 50 + 5 -width/2
        text: (0.25*idea.xLow + 0.75*idea.xHigh).toPrecision(3)
        color: "#a6b0cb"
    }

    TextInput
    {
        validator: DoubleValidator{}
        y: 313
        x: 450 + 50 + 5  -width/2
        text: idea.xHigh.toPrecision(3)
        color: "#a6b0cb"
        selectByMouse: true
        font.underline: true
        onEditingFinished:
        {
            idea.setXHigh(text);
        }
    }

    CheckBox
    {
        id: checkbox
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -10
        anchors.right: parent.right
        text: "Fit Axis";
        checked: idea.autoFit;
        onClicked:
        {
            idea.setAutoFit(checked);
        }
        Material.accent: "#a6b0cb"
        Material.foreground: "#a6b0cb"
        Rectangle
        {
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            radius: 5
            color: "#1a1a1a"
        }
    }

    Item
    {
        id: continuousPlotArea
        anchors.centerIn: gridImage
        width: 450
        height: 300
        clip: true
        visible: idea.valid && displayContinuous;
        opacity: plotOpacity;

        Shape
        {
            id: plotLine
            anchors.fill: parent

            ShapePath
            {
                id: plotShapePath
                fillColor: "transparent"
                strokeColor: "#59a72f"
                strokeWidth: 2

                startX: 0;
                startY: 300;
            }
        }
    }

    Item
    {
        id: discretePlotArea
        opacity: plotOpacity;
        anchors.centerIn: gridImage
        width: 450
        height: 301
        clip: true
        visible: idea.valid && !displayContinuous;
    }

    function clearPath()
    {
        // Empty the shape path.
        plotShapePath.pathElements = [];

        //clearPath the discretePlotArea.
        for(var i = 0; i < discretePlotArea.children.length; i++)
        {
            discretePlotArea.children[i].destroy();
        }
    }

    Connections
    {
        target: idea;

        function onDisplayContinuousDistribution(xValues, yValues)
        {
            displayContinuous = true;
            root.clearPath();

            //Start the shape path in the correct location.
            plotShapePath.startX = xValues[0];
            plotShapePath.startY = 301;

            for(let i = 0; i < xValues.length; i++)
            {
                let pathLine = Qt.createQmlObject("import QtQuick 2.12; import QtQuick.Shapes 1.12; PathLine{}",
                                                  plotShapePath);
                pathLine.x = xValues[i];
                pathLine.y = yValues[i];

                plotShapePath.pathElements.push(pathLine);
            }
        }
        function onDisplayDiscreteDistribution(xValues, yValues)
        {
            displayContinuous = false;
            root.clearPath()

            let comp;
            let obj;
            let i = 0
            for(i = 0; i < xValues.length - 1; i++)
            {
                comp = Qt.createComponent("../DistributionDisplayDiscreteDot.qml");
                obj = comp.createObject(discretePlotArea,
                                        {x: xValues[i] - 3,
                                            y: yValues[i] - 3,
                                            horizLineLength: (xValues[i+1] - xValues[i]),
                                            dotColor: plotShapePath.strokeColor})
            }
            comp = Qt.createComponent("../DistributionDisplayDiscreteDot.qml");
            obj = comp.createObject(discretePlotArea,
                                    {x: xValues[i] - 3,
                                        y: yValues[i] - 3,
                                        horizLineLength: (xValues[i] - xValues[i-1]),
                                        dotColor: plotShapePath.strokeColor})
        }
    }
}

