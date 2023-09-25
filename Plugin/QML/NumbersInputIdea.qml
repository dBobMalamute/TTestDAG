import QtQuick 2.12

FocusScope
{
    width: 108
    height: 208

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: 2

        radius: 4

        color: "#1a1a1a"
        border.width: 2
        border.color: "#333333"

        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor;
            acceptedButtons: Qt.NoButton
        }
    }
    TextEdit
    {
        anchors.fill: parent
        anchors.margins: 4
        id: numsInput
        font.bold: true;
        font.pointSize: 16;
        font.family: "verdana"
        color: idea.outPortLabelColors[0]
        selectByMouse: true;
        text: idea.getNums();
        focus: true;
        wrapMode: TextEdit.Wrap;

        onEditingFinished:
        {
            idea.setNums(text)
        }

        //At first this might seem useless, but it's necessary for
        //undo/redo.
        Connections
        {
            target: idea;
            function onNumsChanged()
            {
                numsInput.text = idea.getNums();
            }
        }
    }
}
