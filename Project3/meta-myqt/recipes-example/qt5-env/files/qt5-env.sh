#!/bin/sh

# export QT_LOGGING_RULES=qt.qpa.*=true # Optional for logging
#export QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf
#export QT_QPA_EGLFS_INTEGRATION=kms
#export QT_QPA_EGLFS_INTEGRATION=eglfs_kms # kms doesn't work on boot2qt but eglfs_kms
export QT_QPA_PLATFORM=eglfs_fkms
#export QT_QPA_EGLFS_KMS_ATOMIC=1
#zexport XDG_RUNTIME_DIR=/run/user/0

#ip link set can0 up type an birtare 5000
#cd usr/bin
#simple
# or 
/usr/bin/dashboard
