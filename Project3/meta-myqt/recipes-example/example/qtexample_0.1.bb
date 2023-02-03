SUMMARY = "QT Example Recipe"
LICENSE = "CLOSED"

SRC_URI = "file://untitled.pro \
           file://qtexample.cpp"

DEPENDS += "qtbase"
RDEPENDS_${PN} += "qtwayland"

S = "${WORKDIR}"

inherit qmake5

    
do_install() {
	     install -d ${D}${bindir}
	     install -m 0775 QTexam ${D}${bindir}
}
