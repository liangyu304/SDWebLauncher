#include "webui_control.h"
#include <QDebug>
#include <QProcess>
#include <QDesktopServices>
#include <QUrl>
#include <QCoreApplication>
#include <QTimer>

WebUiControl::WebUiControl(QObject *parent)
    : QObject{parent}
{
    process_ = new QProcess(this);

    connect(process_, &QProcess::readyRead, this, [=](){
        QByteArray output = process_->readAll();
        qDebug() << QString::fromLocal8Bit(output);
        cmd_ = QString::fromLocal8Bit(output);
        emit cmdChanged();
    });

    process_->setProcessChannelMode(QProcess::MergedChannels);
    process_->setProgram("E:/stable-diffusion-webui/venv/Scripts/python.exe");
    process_->setWorkingDirectory("E:/stable-diffusion-webui");
}

WebUiControl::~WebUiControl()
{
}

void WebUiControl::StartWebUi()
{
    auto *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, [=](){
        cmd_ = "test11111111111111111111111111111111111 \r\n";
        emit cmdChanged();
    });

    timer->start(100);

//    QStringList agentName;
//    agentName << "-u" << "E:/stable-diffusion-webui/launch.py" << "--xformers";
//    process_->setArguments(agentName);
//    process_->start();
}

void WebUiControl::StopWebUi()
{
//    process_->close();
}

void WebUiControl::setName(QString name)
{

}
