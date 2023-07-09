#ifndef WEBUICONTROL_H
#define WEBUICONTROL_H

#include <QObject>
#include <QProcess>

class WebUiControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString cmd READ cmd WRITE setName NOTIFY cmdChanged) //自定义属性，操作包括： 读、写和通知。Qml可以读写、获取通知
public:
    explicit WebUiControl(QObject *parent = nullptr);
    ~WebUiControl() override;

    QString cmd() const {
        return cmd_;
    }

signals:
    void cmdChanged();

public slots:
    void StartWebUi();
    void StopWebUi();
    void setName(QString name);

private:
    QProcess* process_{};
    QString cmd_;
};

#endif // WEBUICONTROL_H
