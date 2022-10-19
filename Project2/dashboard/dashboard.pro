TEMPLATE = app
TARGET = dashboard
INCLUDEPATH += .
QT += \
    quick \
    widgets \
    dbus widgets

HEADERS += chat.h

SOURCES += \
    main.cpp

RESOURCES += \
    dashboard.qrc

FORMS += chatmainwindow.ui chatsetnickname.ui

DBUS_ADAPTORS += org.example.chat.xml
DBUS_INTERFACES += org.example.chat.xml

OTHER_FILES += \
    qml/dashboard.qml \
    qml/DashboardGaugeStyle.qml \
    qml/IconGaugeStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/ValueSource.qml \

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols/extras/dashboard
INSTALLS += target
