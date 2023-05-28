#ifndef PCMANAGER_H
#define PCMANAGER_H

#include <QObject>
#include <QTimer>

class PCManager : public QObject
{
    Q_OBJECT
public:
    explicit PCManager(QObject *parent = nullptr);

    // Get Name
    QString GetCPU();
    QString GetGPU(); // NVIDIA 4090
    QString GetMem();

    // time 5s
    void GetCPUUsage();
    void GetGPUUsage();
    void GetMemUsage();
signals:

private:
    QTimer *timer{};

};

#endif // PCMANAGER_H
