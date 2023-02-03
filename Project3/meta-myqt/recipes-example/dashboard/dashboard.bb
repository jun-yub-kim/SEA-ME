DESCRIPTION = "QT application"

LICENSE = "CLOSED"
inherit qmake5
DEPENDS = " qtbase qtquickcontrols2"

  
SRC_URI += "file://dashboard.pro.user \
            file://qrc_dashboard.cpp \
            file://dashboard.pro \
            file://dashboard.qrc \
            file://images/fuel-icon.png \
            file://images/temperature-icon.png \
            file://qml/dashboard.qml \
            file://qml/DashboardGaugeStyle.qml \
            file://qml/IconGaugeStyle.qml \
            file://qml/TachometerStyle.qml \
            file://qml/TurnIndicator.qml \
            file://qml/ValueSource.qml \
            file://fonts/DejaVuSans.ttf \              
            file://main.cpp"
S = "${WORKDIR}"

do_configure() {
    qmake ${S}/dashboard.pro
}


do_install(){
    install -d ${D}${bindir}
    install -m 0755 dashboard ${D}${bindir}
}
