DESCRIPTION = "QT application"

LICENSE = "CLOSED"
inherit qmake5
DEPENDS = " qtbase qtscxml"

  
SRC_URI += "file://simple.pro \
            file://qml.qrc \
            file://main.cpp \
            file://main.qml \
            file://simple.pro.user \
            file://MainForm.ui.qml \
            file://deployment.pri"
S = "${WORKDIR}"

do_configure() {
    qmake ${S}/simple.pro
}


do_install(){
    install -d ${D}${bindir}
    install -m 0755 simple ${D}${bindir}
}
