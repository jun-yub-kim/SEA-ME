DESCRIPTION = "QT application"

LICENSE = "CLOSED"
inherit qmake5
DEPENDS = " qtbase qtquickcontrols2"

  
SRC_URI += "file://cheese.jpg \
            file://main.cpp \
            file://mice.qrc \
            file://mouse.cpp \
            file://collidingmice.pro \
            file://mouse.h"
S = "${WORKDIR}"

do_configure() {
    qmake ${S}/collidingmice.pro
}


do_install(){
    install -d ${D}${bindir}
    install -m 0755 colidingmice ${D}${bindir}
}
