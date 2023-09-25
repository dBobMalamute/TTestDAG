import QtQuick 2.12
import QtQuick.Controls 2.12

FocusScope
{
    width: Math.max(statisticalTestValue.width, pValue.width) + 6
    height: statisticalTestValue.height + pValue.height + 4

    property string statisticalTestLetter: ""

    Label
    {
        id: statisticalTestValue
        visible: idea.valid;
        x: 3
        font.bold: true
        font.pointSize: 12
        //font.family: "inconsolata"
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
        color: idea.outPortLabelColors[0]
        focus: true;
        textFormat: Label.RichText

        text: statisticalTestLetter + ": " + idea.statisticalTestValue.toPrecision(3);

    }
    TextInput
    {
        id: pValue
        anchors.bottom: parent.bottom
        x: 3
        visible: idea.valid;
        font.bold: true
        font.pointSize: 12
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
        color: idea.outPortLabelColors[1]
        selectByMouse: true
        readOnly: true

        text: "p: " + idea.pValue.toPrecision(3);
        onActiveFocusChanged:
        {
            if(activeFocus)
                pValue.selectAll();
            else
                pValue.deselect();
        }
    }

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: -3
        border.color: "#333333"
        border.width: 2
        radius: 2
        color: "#1a1a1a"
        z: -1
    }
}
