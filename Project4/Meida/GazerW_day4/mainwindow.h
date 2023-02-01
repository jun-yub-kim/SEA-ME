#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QMenuBar>
#include <QAction>
#include <QGraphicsScene>
#include <QGraphicsView>
#include <QStatusBar>
#include <QLabel>
#include <QListView>
#include <QCheckBox>
#include <QPushButton>
#include <QGraphicsPixmapItem>
#include <QMutex>
#include <QStandardItemModel>
#include <QMainWindow>
#include <QCameraInfo>
#include <QMessageBox>
#include <QCamera>
#include <QCameraViewfinder>

#include "capture_thread.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
         QMenu *fileMenu;

         QAction *cameraInfoAction;
         QAction *openCameraAction;
         QAction *exitAction;

         QGraphicsScene *imageScene;
         QGraphicsView *imageView;

         QCheckBox *monitorCheckBox;
         QPushButton *recordButton;

         QListView *saved_list;
         QStatusBar *mainStatusBar;
         QLabel *mainStatusLabel;

         cv::Mat currentFrame;

         // for capture thread
         QMutex *data_lock;
         CaptureThread *capturer;

         #ifdef GAZER_USE_QT_CAMERA
            QCamera *camera;
            QCameraViewfinder *viewfinder;
         #endif

private:
         void initUI();
         void createActions();

private slots:
    void showCameraInfo();
    void openCamera();
    void updateFrame(cv::Mat*);


};
#endif // MAINWINDOW_H
