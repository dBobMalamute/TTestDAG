#include "Plugin.h"

#include "NumberDataType.h"
#include "NumbersDataType.h"
#include "DistributionDataType.h"

#include "TextAreaIdea.h"

#include "NumberDisplayIdea.h"
#include "NumberInputIdea.h"
#include "NumbersMeanIdea.h"
#include "NumbersInputIdea.h"

#include "GaussianDistributionIdea.h"
#include "DistributionSamplerIdea.h"
#include "OneSampleOneSidedTTestIdea.h"

QString Plugin::PluginName()
{
    return "PLUGIN";
}

QStringList Plugin::authors()
{
    return QStringList("dBob");
}

QString Plugin::PluginDescription()
{
    return "";
}

void Plugin::registerIdeas(std::shared_ptr<IdeaRegistry> ideaRegistry)
{
    ideaRegistry->registerIdea<NumberDisplayIdea>();
    ideaRegistry->registerIdea<NumberInputIdea>();
    ideaRegistry->registerIdea<NumbersMeanIdea>();
    ideaRegistry->registerIdea<TextAreaIdea>();
    ideaRegistry->registerIdea<NumbersInputIdea>();
    ideaRegistry->registerIdea<GaussianDistributionIdea>();
    ideaRegistry->registerIdea<DistributionSamplerIdea>();
    ideaRegistry->registerIdea<OneSampleOneSidedTTestIdea>();

    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/StatisticTemplate.qml"), "com.malamute.numbers", 1, 0, "StatisticTemplate");
    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/DistributionDisplay.qml"), "com.malamute.distributions", 1, 0, "DistributionDisplay");
    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/SamplerTemplate.qml"), "com.malamute.distributions", 1, 0, "SamplerTemplate");
    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/StatisticalTestMinimized.qml"), "com.malamute.statisticaltests", 1, 0, "StatisticalTestMinimized");
    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/StatisticalTestTemplate.qml"), "com.malamute.statisticaltests", 1, 0, "StatisticalTestTemplate");
    qmlRegisterType(QUrl("qrc:/QML/QMLTemplates/BridgeRailings.qml"), "com.malamute.statisticaltests", 1, 0, "BridgeRailings");
}


void Plugin::registerDataTypeAttributes(std::shared_ptr<DataTypeRegistry> dataTypeRegistry)
{
    dataTypeRegistry->registerDataTypeAttributes<NumberDataTypeAttributes>();
    dataTypeRegistry->registerDataTypeAttributes<NumbersDataTypeAttributes>();
    dataTypeRegistry->registerDataTypeAttributes<DistributionDataTypeAttributes>();
}

void Plugin::registerToolbars(std::shared_ptr<ToolbarRegistry> toolbarRegistry)
{
    QStringList orderList;
    orderList << Magic<TextAreaAttributes>::cast().listName();
    orderList << Magic<NumberInputAttributes>::cast().listName();
    orderList << Magic<NumberDisplayAttributes>::cast().listName();
    orderList << Magic<NumbersInputAttributes>::cast().listName();
    orderList << Magic<NumbersMeanAttributes>::cast().listName();
    orderList << Magic<GaussianDistributionAttributes>::cast().listName();
    orderList << Magic<DistributionSamplerAttributes>::cast().listName();
    orderList << Magic<OneSampleOneSidedTTestAttributes>::cast().listName();

    toolbarRegistry->registerToolbar(PluginName(),orderList);
}
