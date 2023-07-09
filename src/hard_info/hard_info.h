#ifndef HARDINFO_H
#define HARDINFO_H

#include <QObject>

class HardInfo : public QObject
{
    Q_OBJECT
public:
    explicit HardInfo(QObject *parent = nullptr);

signals:

};

#endif // HARDINFO_H
