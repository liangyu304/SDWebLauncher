#include "webui_control.h"
#include <QDebug>
#include <QProcess>
#include <QDesktopServices>
#include <QUrl>
#include <QCoreApplication>

WebUiControl::WebUiControl(QObject *parent)
    : QObject{parent}
{
    process_ = new QProcess(this);

    connect(process_, &QProcess::readyRead, this, [=](){
        QByteArray output = process_->readAll();
        qDebug() << QString::fromLocal8Bit(output);
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
    QStringList agentName;
    agentName << "E:/stable-diffusion-webui/launch.py";
    process_->setArguments(agentName);
    process_->start();
}

void WebUiControl::StopWebUi()
{
    process_->close();
}
