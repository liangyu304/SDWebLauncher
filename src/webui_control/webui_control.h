#ifndef WEBUICONTROL_H
#define WEBUICONTROL_H

#include <QObject>
#include <QProcess>

class WebUiControl : public QObject
{
    Q_OBJECT
public:
    explicit WebUiControl(QObject *parent = nullptr);
    ~WebUiControl();

signals:
public slots:
    void StartWebUi();
    void StopWebUi();


private:
    QProcess* process_{};
    qint64 pid_;
};

#endif // WEBUICONTROL_H
