#ifndef NUMBERSTONUMBERTEMPLATE_H
#define NUMBERSTONUMBERTEMPLATE_H

#include "../../MalamuteCore/InheritedClasses/Idea.h"
#include "../NumberDataType.h"
#include "../NumbersDataType.h"

class NumbersToNumberTemplate : public Idea
{
    Q_OBJECT

    Q_PROPERTY(double statistic READ statistic WRITE setStatistic NOTIFY statisticChanged)

    Q_PROPERTY(double lowBound READ lowBound WRITE setLowBound NOTIFY lowBoundChanged)
    Q_PROPERTY(double upBound READ upBound WRITE setUpBound NOTIFY upBoundChanged)
    Q_PROPERTY(bool autoFit READ autoFit WRITE setAutoFit NOTIFY autoFitChanged)
    Q_PROPERTY(double animationSpeed READ animationSpeed WRITE setAnimationSpeed NOTIFY animationSpeedChanged)

    Q_PROPERTY(QString xAxisLabel READ xAxisLabel WRITE setXAxisLabel NOTIFY xAxisLabelChanged)

public:
    explicit NumbersToNumberTemplate();

    QJsonObject save() const override;
    void load(const QJsonObject &) override;

    void onNewDataIn(std::shared_ptr<DataType> dataType, PlugNumber plugNumber) override;
    std::shared_ptr<DataType> dataOut(PlugNumber plugNumber) override;

    void resetDisplay() override;

    double lowBound() const;
    double upBound() const;
    bool autoFit() const;

    double animationSpeed() const;

    double statistic() const;

    QString xAxisLabel() const;

signals:
    void lowBoundChanged(double lowBound);
    void upBoundChanged(double upBound);
    void autoFitChanged(bool autoFit);
    void animationSpeedChanged(double animationSpeed);

    void statisticChanged(double statistic);
    void xAxisLabelChanged(QString xAxisLabel);

public slots:
    void setLowBound(double lowBound);
    void setUpBound(double upBound);
    void setAutoFit(bool autoFit);
    void setAnimationSpeed(double animationSpeed);
    void setXAxisLabel(const QString &newXAxisLabel);

    virtual void playAnimation();

    void setStatistic(double statistic);

protected:
    std::weak_ptr<NumbersDataType> m_numbersInput;
    std::shared_ptr<NumberDataType> m_output;

    virtual void validate() = 0;
    virtual void compute() = 0;
    virtual void prepareVisuals() = 0;

    double m_statistic;

    double m_lowBound;
    double m_upBound;
    bool m_autoFit;
    double m_animationSpeed;
    QString m_xAxisLabel;

    std::vector<double> m_nums;
};

#endif // NUMBERSTONUMBERTEMPLATE_H
