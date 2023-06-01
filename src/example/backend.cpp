#include "backend.h"
#include <QDebug>

Backend::Backend(QObject *parent) : QObject(parent)
{
}

void Backend::cppFunction()
{
    // 在此处编写你的C++逻辑
    qDebug() << "C++ function called";
    emit cppSignal();
}
