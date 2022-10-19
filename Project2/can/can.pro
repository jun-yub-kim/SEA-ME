QT += \
    serialbus widgets \
    dbus widgets
requires(qtConfig(combobox))

TARGET = can
TEMPLATE = app

SOURCES += \
    bitratebox.cpp \
    connectdialog.cpp \
    main.cpp \
    mainwindow.cpp \
    sendframebox.cpp \

HEADERS += \
    bitratebox.h \
    chat.h \
    connectdialog.h \
    mainwindow.h \
    sendframebox.h

FORMS   += mainwindow.ui \
    chatmainwindow.ui \
    chatsetnickname.ui \
    connectdialog.ui \
    sendframebox.ui

DBUS_ADAPTORS += org.example.chat.xml
DBUS_INTERFACES += org.example.chat.xml

RESOURCES += can.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/serialbus/can
INSTALLS += target
