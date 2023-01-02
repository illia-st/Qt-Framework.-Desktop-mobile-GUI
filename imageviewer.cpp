#include "imageviewer.h"

ImageViewer::ImageViewer(QObject* parent): QObject(parent)
{
    connect(this, &ImageViewer::parseFolder, this, &ImageViewer::onParseFolder);
    connect(this, &ImageViewer::readyToView, this, &ImageViewer::onReadyToView);
}


void ImageViewer::onParseFolder(const QUrl& url_folder){
    try{
        QString folder = url_folder.toLocalFile();
        qInfo() << "To parse folder " << folder;
        // clear main container from previous values
        m_images.clear();
        // parse a given directory
        QDir directory(folder);
        QStringList filters;
        filters << "*.jpg" << "*.png" << "*.jpeg" << "*.bmp" << "*.svg";
        QStringList filenames = directory.entryList(filters, QDir::Files|QDir::NoDotAndDotDot);
        foreach(QString filename, filenames) {
            QString picture {folder + "/" + filename};
            m_images.append(picture);
        }
        // inform that new images are ready
        emit readyToView();
    } catch(const std::exception& ex){
        qInfo() << ex.what();
    }
}
void ImageViewer::onReadyToView(){ }
