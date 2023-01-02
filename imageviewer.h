#pragma once
#include <QObject>
#include <QDebug>
#include <QDir>
#include <QUrl>
#include <QList>
#include <QVariantList>

class ImageViewer: public QObject
{
    Q_OBJECT
    // add property which contains parsed images
     Q_PROPERTY(QVariantList images MEMBER m_images NOTIFY readyToView)
public:
    ImageViewer(QObject* parent = nullptr);
signals:
    void parseFolder(const QUrl& url_folder);
    void readyToView();
private slots:
    void onParseFolder(const QUrl& url_folder);
    void onReadyToView();
private:
    QVariantList m_images;
};

