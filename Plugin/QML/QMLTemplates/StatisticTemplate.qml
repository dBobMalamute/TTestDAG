import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import com.malamute.numbers 1.0
import QtQuick.Controls.Material 2.12

Item
{
    width: 500
    height: 294

    Rectangle
    {
        id: backgroundRect
        width: 500
        height: 258
        radius: 4
        color: "#1a1a1a"
        border.width: 2
        border.color: "#333333"


    }

    Rectangle
    {
        id: axisLabelRectangle
        width: 200
        height: 32
        anchors.left: controlsRow.right
        anchors.leftMargin: 10
        anchors.right: statisticTextInput.left
        anchors.rightMargin: 14
        anchors.top: backgroundRect.bottom
        anchors.topMargin: -4
        color: "#1a1a1a"
        radius: 4
        z: 100

        TextInput
        {
            anchors.centerIn: parent
            color: "#a6b0cb"
            selectByMouse: true
            text: idea.xAxisLabel;
            font.bold: true;
            font.pointSize: 12
            onEditingFinished:
            {
                idea.setXAxisLabel(text);
            }
        }
    }

    Image
    {
        id: gridImage
        x: 20
        y: 4
        width: 460
        height: 237
        source: "qrc:/Images/MeanGrid.png"
        fillMode: Image.PreserveAspectFit
    }

    TextInput
    {
        id: lowInput
        validator: DoubleValidator{}
        y: 239
        x: 20 + 5 - width/2
        text: parseFloat(idea.lowBound.toPrecision(4))
        color: "#a6b0cb"
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setLowBound(lowInput.text);
        }
    }

    Text
    {
        y: 239
        x: 82.5 + 50 + 5 -width/2
        text: parseFloat((0.75*idea.lowBound + 0.25*idea.upBound).toPrecision(4))
        color: "#a6b0cb"
    }

    Text
    {
        y: 239
        x: 195 + 50 + 5 -width/2
        text: parseFloat((0.5*idea.lowBound + 0.5*idea.upBound).toPrecision(4))
        color: "#a6b0cb"
    }

    Text
    {
        y: 239
        x: 307.5 + 50 + 5 -width/2
        text: parseFloat((0.25*idea.lowBound + 0.75*idea.upBound).toPrecision(4))
        color: "#a6b0cb"
    }

    TextInput
    {
        id: upInput
        y: 239
        x: 420 + 50 + 5  -width/2
        text: parseFloat(idea.upBound.toPrecision(4));
        color: "#a6b0cb"
        validator: DoubleValidator{}
        selectByMouse: true
        font.underline: true;
        onEditingFinished:
        {
            idea.setUpBound(upInput.text);
        }
    }

    Rectangle
    {
        id: controlsRow
        radius: 4
        color: "#1a1a1a"
        border.width: 2
        border.color: "#333333"
        height: 32
        width: animationButton.width + fitAxisCheckbox.width + 10;

        anchors.bottom: parent.bottom
        x: 4

        Button
        {
            id: animationButton
            height: 32
            text: "Animate"
            x: 6
            anchors.verticalCenter: parent.verticalCenter
            enabled: idea.valid;
            onClicked:
            {
                idea.playAnimation();
            }
            font.capitalization: Font.MixedCase
            Material.background: idea.inPortLabelColors[0]
            Material.foreground:  "#1a1a1a"
        }

        CheckBox
        {
            id: fitAxisCheckbox;
            text: "Fit Axis"
            anchors.right: parent.right
            anchors.rightMargin: -2
            anchors.verticalCenter: parent.verticalCenter
            checked: idea.autoFit;
            onCheckedChanged:
            {
                idea.setAutoFit(checked);
            }
            Material.accent: "#a6b0cb"
            Material.foreground: "#a6b0cb"
        }
    }
    TextInput
    {
        id: statisticTextInput
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 8
        anchors.bottomMargin: 2
        visible: idea.valid;
        font.bold: true
        font.pointSize: 16
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
        color: idea.outPortLabelColors[0]
        selectByMouse: true
        readOnly: true
        focus: true;

        text: idea.statistic.toPrecision(4);

        onActiveFocusChanged:
        {
            if(activeFocus)
                statisticTextInput.selectAll();
            else
                statisticTextInput.deselect();
        }
        Rectangle
        {
            anchors.fill: parent
            anchors.leftMargin: -4
            anchors.rightMargin: -4
            anchors.topMargin: -2
            anchors.bottomMargin: -2

            color: "#1a1a1a"
            border.width: 2
            border.color: "#333333"
            radius: 4
            z: -1
        }
    }
}
