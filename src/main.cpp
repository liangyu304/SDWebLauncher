#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "test/backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Backend backend;

    QQmlApplicationEngine engine;
    engine.addImportPath(TaoQuickImportPath);

    engine.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);

    engine.rootContext()->setContextProperty("backend", &backend);

    const QUrl url(u"qrc:/SdWebLauncher/src/qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
