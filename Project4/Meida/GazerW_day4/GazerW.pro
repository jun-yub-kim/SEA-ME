# Using OpenCV or QCamera
DEFINES += GAZER_USE_QT_CAMERA=1
QT       += core gui multimedia multimediawidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    capture_thread.cpp \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    capture_thread.h \
    mainwindow.h

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32 {
    INCLUDEPATH += D:/opencv/release/install/include
    LIBS += -Ld:/opencv/release/install/x64/mingw/bin \
     -lopencv_core453 \
     -lopencv_imgproc453 \
     -lopencv_videoio453
}
