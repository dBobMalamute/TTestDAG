#ifndef PLUGIN_H
#define PLUGIN_H

#include "../MalamuteCore/InheritedClasses/MalamutePlugin.h"

class Plugin : public MalamutePlugin
{
    Q_OBJECT

public:
    QString PluginName() override;
    QStringList authors() override;
    QString PluginDescription() override;
    void registerIdeas(std::shared_ptr<IdeaRegistry> ideaRegistry) override;
    void registerDataTypeAttributes(std::shared_ptr<DataTypeRegistry> dataTypeRegistry) override;
    void registerToolbars(std::shared_ptr<ToolbarRegistry> toolbarRegistry) override;
};

#endif // PLUGIN_H
