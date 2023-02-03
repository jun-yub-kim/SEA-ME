SUMMARY = "A basic Qt5 dev image"

require recipes-core/images/core-image-minimal.bb 

IMAGE_FEATURES += "splash"

IMAGE_INSTALL:append = " \
    dashboard \
    colidingmice \
    qt5-env \
    psplash \
"

QT_BASE = " \
    qtbase \
    qtbase-dev \
    qtbase-mkspecs \
    qtbase-plugins \
    qtbase-tools \
"

 
QT_PKGS = " \
    qt3d \
    qt3d-dev \
    qt3d-mkspecs \
    qtcharts \
    qtcharts-dev \
    qtcharts-mkspecs \
    qtconnectivity-dev \
    qtconnectivity-mkspecs \
    qtquickcontrols \
    qtquickcontrols2 \
    qtquickcontrols2-dev \
    qtquickcontrols2-mkspecs \
    qtdeclarative \
    qtdeclarative-dev \
    qtdeclarative-mkspecs \
    qtgraphicaleffects \
    qtgraphicaleffects-dev \
    qtx11extras \
    qtquickcontrols \
"
 
IMAGE_INSTALL += " \
    ${QT_BASE} \
    ${QT_PKGS} \
"

Auto_start ?= " \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"

local_autologin () {
    sed -i -e 's/^\(ExecStart *=.*getty \)/\1--autologin root /' ${Auto_start}
}

ROOTFS_POSTPROCESS_COMMAND += "local_autologin; "
 
export IMAGE_BASENAME = "basic-qt5-image"
