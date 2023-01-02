#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "imageviewer.h"


int main(int argc, char *argv[])
{
    // to make FolderDialog type work I have to use QApplication
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/AprioritQT_DeskMob_GUI/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    // add context
    ImageViewer* viewer = new ImageViewer;
//    QObject* obj = viewer;
    static_cast<QObject*>(viewer)->setProperty("images", QList<QString>{});

    engine.rootContext()->setContextProperty("viewer", viewer);

    engine.load(url);

    return app.exec();
}
