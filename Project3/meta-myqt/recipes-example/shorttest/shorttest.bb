DESCRIPTION = "QT application"

LICENSE = "CLOSED"
inherit qmake5
DEPENDS = " qtbase"

  
SRC_URI += "file://shorttest.pro \
           file://shortmain.cpp  \
           file://shortmain.qml  \
           file://shortqml.qrc"
S = "${WORKDIR}"

do_configure() {

    qmake ${S}/shorttest.pro
}


do_install(){
    install -d ${D}${bindir}
    install -m 0755 shorttarget ${D}${bindir}
}
