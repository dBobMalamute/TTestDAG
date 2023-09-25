import QtQuick 2.12

FocusScope
{
    width: textInput.width + 8
    height: textInput.height + 4

    Rectangle
    {
        anchors.fill: parent

        color: "#1a1a1a"
        border.width: 2
        border.color: "#333333"
        radius: 4
        z: -1
    }

    TextInput
    {
        id: textInput
        anchors.centerIn: parent
        visible: idea.valid;
        font.bold: true
        font.pointSize: 12
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
                textInput.selectAll();
            else
                textInput.deselect();
        }
    }
}
