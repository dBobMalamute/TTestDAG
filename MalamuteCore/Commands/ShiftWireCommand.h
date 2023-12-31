#ifndef SHIFTWIRECOMMAND_H
#define SHIFTWIRECOMMAND_H

#include "UndoCommand.h"
#include <QJsonObject>

class Corkboard;

class ShiftWireCommand: public UndoCommand
{
public:
    ShiftWireCommand(const QJsonObject& oldWire, const QJsonObject& newWire,
                           Corkboard* corkboard, bool actionNeeded);

    void undo() override;
    void redo() override;

private:
    Corkboard* m_corkboard;
    QJsonObject m_oldWire;
    QJsonObject m_newWire;
    bool m_actionNeeded;
};

#endif // SHIFTWIRECOMMAND_H
