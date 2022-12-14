# Intro

Third project is making an Operating System for Raspberry Pi 4.

In previous projects, we already made several program

Sensor checker / CAN / D-Bus / Dashboard.

We are gonna make an Operating System to operate these whole programs.

So.. we need to install CAN / D-Bus / QT in our custom recipes.\

# 참고한 사이트들

[https://github.com/jynik/ready-set-yocto](https://github.com/jynik/ready-set-yocto)

# About Yocto

- About Yocto
    
    ### OS
    
    In Project 1
    
    We installed [2021-12-02-raspios-buster.zip](https://downloads.raspberrypi.org/raspios_oldstable_lite_armhf/images/raspios_oldstable_lite_armhf-2021-12-02/2021-12-02-raspios-buster-armhf-lite.zip) using Rasbian Imager. 
    
    But in this Project. We have to install OS In sd card without using Rasbian Imager.
    
    ### Yocto
    
    @[https://selfish-developer.com/entry/Yocto란-무엇인가](https://selfish-developer.com/entry/Yocto%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80)
    
    To use Yocto, you must use git skillfully. Yocto automatically patches source code to new version through git.
    
    ### Poky
    
    also there’s lots of  extension
    
    But, we use Raspberrypi. So we will use Raspberrypi extension.
    
    @[https://github.com/agherzan/meta-raspberrypi/tree/kirkstone](https://github.com/agherzan/meta-raspberrypi/tree/kirkstone)
    
    ### BitBake
    
    ### AGL
    
    ### BSP
    
    board support package
    
    maybe 
    
    ```jsx
     /home/**username**/yocto/kirkstone/poky/meta \
      /home/**username**/yocto/kirkstone/poky/meta-poky \
      /home/**username**/yocto/kirkstone/poky/meta-yocto-bsp \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-oe \
      /home/**username**//yocto/kirkstone/meta-openembedded/meta-multimedia \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-networking \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-python \
      /home/**username**/yocto/kirkstone/meta-raspberrypi \
    ```
    
    this will be BSP
    

# Make Basic OS

- Make Basic OS
    
    ## 1. Poky
    
    `PC`
    
    1. Install dependencies
    
    ```jsx
    sudo apt install build-essential chrpath gawk git bmap-tools texinfo diffstat
    ```
    
    1. Make a directory to run yocto. In my case I made it in the home directory
    
    ```jsx
    mkdir ~yocto
    cd ~/yocto
    mkdir kirkstone
    cd kirkstone
    mkdir builds
    mkdir downloads
    ```
    
    1. Clone poky
    
    ```jsx
    git clone -b kirkstone git://git.yoctoproject.org/poky.git
    ```
    
    1. Clone poky raspberry pi extension / dependencies of raspberry pi extension
    
    ```jsx
    git clone -b kirkstone https://github.com/agherzan/meta-raspberrypi.git
    git clone -b kirkstone git://git.openembedded.org/meta-openembedded
    ```
    
    1. Enter build environment
    
    ```jsx
    source oe-init-build-env projectname
    ```
    
    source oe-init-build-env 경로명
    
    이 명령어를 사용시, 해당 경로에 build디렉토리가 생성된다.
    
    나의 경우는 ↓명령어로 디렉토리를 설정해주었다.
    
    ```jsx
    source ~/yocto/kirkstone/poky/oe-init-build-env ../**Projectname**
    ```
    
    - In my case
        
        ```jsx
        source ~/yocto/kirkstone/poky/oe-init-build-env ../**raspberrypi4**
        ```
        
    
    코드설명 : 최신상태로 변경된 poky/oe-init-build-env라는 파일을 실행시킨 후, builds/rpi라는 폴더에 build파일 만듦.
    
    1. Add layers
    
    Go to the directory just before you made.
    
    ```jsx
    cd ~/yocto/kirkstone/builds/raspberrypi4/conf
    vi bblayers.conf
    ```
    
    add below lines.
    
    ```jsx
      /home/**username**/yocto/kirkstone/poky/meta \
      /home/**username**/yocto/kirkstone/poky/meta-poky \
      /home/**username**/yocto/kirkstone/poky/meta-yocto-bsp \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-oe \
      /home/**username**//yocto/kirkstone/meta-openembedded/meta-multimedia \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-networking \
      /home/**username**/yocto/kirkstone/meta-openembedded/meta-python \
      /home/**username**/yocto/kirkstone/meta-raspberrypi \
    ```
    
    - bblayers.conf (in my case)
        
        ```jsx
        # POKY_BBLAYERS_CONF_VERSION is increased each time build/conf/bblayers.conf
        # changes incompatibly
        POKY_BBLAYERS_CONF_VERSION = "2"
        
        BBPATH = "${TOPDIR}"
        BBFILES ?= ""
        
        BBLAYERS ?= " \
          /home/seame-fablab/yocto/kirkstone/poky/meta \
          /home/seame-fablab/yocto/kirkstone/poky/meta-poky \
          /home/seame-fablab/yocto/kirkstone/poky/meta-yocto-bsp \
          /home/seame-fablab/yocto/kirkstone/meta-openembedded/meta-oe \
          /home/seame-fablab//yocto/kirkstone/meta-openembedded/meta-multimedia \
          /home/seame-fablab/yocto/kirkstone/meta-openembedded/meta-networking \
          /home/seame-fablab/yocto/kirkstone/meta-openembedded/meta-python \
          /home/seame-fablab/yocto/kirkstone/meta-raspberrypi \
          "
        ```
        
    
    1. Update MACHINE and change directory 
    
    ```jsx
    cd ~/yocto/kirkstone/builds/rpi/conf
    vi local.conf
    ```
    
    ```jsx
    MACHINE = "raspberrypi4"
    #DL_DIR ?= "~/yocto/kirkstone/downloads"
    ENABLE_UART = "1"
    RPI_USE_U_BOOT = "1"
    ```
    
    ```jsx
    also attached this
    at the end of line
    
    ENABLE_UART = "1"
    RPI_USE_U_BOOT = "1"
    
    ```
    
    - local.conf (in my case)
        
        ```jsx
        #
        # This file is your local configuration file and is where all local user settings
        # are placed. The comments in this file give some guide to the options a new user
        # to the system might want to change but pretty much any configuration option can
        # be set in this file. More adventurous users can look at
        # local.conf.sample.extended which contains other examples of configuration which
        # can be placed in this file but new users likely won't need any of them
        # initially.
        #
        # Lines starting with the '#' character are commented out and in some cases the
        # default values are provided as comments to show people example syntax. Enabling
        # the option is a question of removing the # character and making any change to the
        # variable as required.
        
        #
        # Machine Selection
        #
        # You need to select a specific machine to target the build with. There are a selection
        # of emulated machines available which can boot and run in the QEMU emulator:
        #
        #MACHINE ?= "qemuarm"
        #MACHINE ?= "qemuarm64"
        #MACHINE ?= "qemumips"
        #MACHINE ?= "qemumips64"
        #MACHINE ?= "qemuppc"
        #MACHINE ?= "qemux86"
        #MACHINE ?= "qemux86-64"
        MACHINE ?= "raspberrypi4"
        #
        # There are also the following hardware board target machines included for 
        # demonstration purposes:
        #
        #MACHINE ?= "beaglebone-yocto"
        #MACHINE ?= "genericx86"
        #MACHINE ?= "genericx86-64"
        #MACHINE ?= "edgerouter"
        #
        # This sets the default machine to be qemux86-64 if no other machine is selected:
        MACHINE = "raspberrypi4"
        
        #
        # Where to place downloads
        #
        # During a first build the system will download many different source code tarballs
        # from various upstream projects. This can take a while, particularly if your network
        # connection is slow. These are all stored in DL_DIR. When wiping and rebuilding you
        # can preserve this directory to speed up this part of subsequent builds. This directory
        # is safe to share between multiple builds on the same machine too.
        #
        # The default is a downloads directory under TOPDIR which is the build directory.
        #
        #DL_DIR = "~/yocto/kirkstone/downloads"
        
        #
        # Where to place shared-state files
        #
        # BitBake has the capability to accelerate builds based on previously built output.
        # This is done using "shared state" files which can be thought of as cache objects
        # and this option determines where those files are placed.
        #
        # You can wipe out TMPDIR leaving this directory intact and the build would regenerate
        # from these files if no changes were made to the configuration. If changes were made
        # to the configuration, only shared state files where the state was still valid would
        # be used (done using checksums).
        #
        # The default is a sstate-cache directory under TOPDIR.
        #
        #SSTATE_DIR ?= "${TOPDIR}/sstate-cache"
        
        #
        # Where to place the build output
        #
        # This option specifies where the bulk of the building work should be done and
        # where BitBake should place its temporary files and output. Keep in mind that
        # this includes the extraction and compilation of many applications and the toolchain
        # which can use Gigabytes of hard disk space.
        #
        # The default is a tmp directory under TOPDIR.
        #
        #TMPDIR = "${TOPDIR}/tmp"
        
        #
        # Default policy config
        #
        # The distribution setting controls which policy settings are used as defaults.
        # The default value is fine for general Yocto project use, at least initially.
        # Ultimately when creating custom policy, people will likely end up subclassing 
        # these defaults.
        #
        DISTRO ?= "poky"
        # As an example of a subclass there is a "bleeding" edge policy configuration
        # where many versions are set to the absolute latest code from the upstream 
        # source control systems. This is just mentioned here as an example, its not
        # useful to most new users.
        # DISTRO ?= "poky-bleeding"
        
        #
        # Package Management configuration
        #
        # This variable lists which packaging formats to enable. Multiple package backends
        # can be enabled at once and the first item listed in the variable will be used
        # to generate the root filesystems.
        # Options are:
        #  - 'package_deb' for debian style deb files
        #  - 'package_ipk' for ipk files are used by opkg (a debian style embedded package manager)
        #  - 'package_rpm' for rpm style packages
        # E.g.: PACKAGE_CLASSES ?= "package_rpm package_deb package_ipk"
        # We default to rpm:
        PACKAGE_CLASSES ?= "package_rpm"
        
        #
        # SDK target architecture
        #
        # This variable specifies the architecture to build SDK items for and means
        # you can build the SDK packages for architectures other than the machine you are
        # running the build on (i.e. building i686 packages on an x86_64 host).
        # Supported values are i686, x86_64, aarch64
        #SDKMACHINE ?= "i686"
        
        #
        # Extra image configuration defaults
        #
        # The EXTRA_IMAGE_FEATURES variable allows extra packages to be added to the generated
        # images. Some of these options are added to certain image types automatically. The
        # variable can contain the following options:
        #  "dbg-pkgs"       - add -dbg packages for all installed packages
        #                     (adds symbol information for debugging/profiling)
        #  "src-pkgs"       - add -src packages for all installed packages
        #                     (adds source code for debugging)
        #  "dev-pkgs"       - add -dev packages for all installed packages
        #                     (useful if you want to develop against libs in the image)
        #  "ptest-pkgs"     - add -ptest packages for all ptest-enabled packages
        #                     (useful if you want to run the package test suites)
        #  "tools-sdk"      - add development tools (gcc, make, pkgconfig etc.)
        #  "tools-debug"    - add debugging tools (gdb, strace)
        #  "eclipse-debug"  - add Eclipse remote debugging support
        #  "tools-profile"  - add profiling tools (oprofile, lttng, valgrind)
        #  "tools-testapps" - add useful testing tools (ts_print, aplay, arecord etc.)
        #  "debug-tweaks"   - make an image suitable for development
        #                     e.g. ssh root access has a blank password
        # There are other application targets that can be used here too, see
        # meta/classes/image.bbclass and meta/classes/core-image.bbclass for more details.
        # We default to enabling the debugging tweaks.
        EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
        
        #
        # Additional image features
        #
        # The following is a list of additional classes to use when building images which
        # enable extra features. Some available options which can be included in this variable
        # are:
        #   - 'buildstats' collect build statistics
        USER_CLASSES ?= "buildstats"
        
        #
        # Runtime testing of images
        #
        # The build system can test booting virtual machine images under qemu (an emulator)
        # after any root filesystems are created and run tests against those images. It can also
        # run tests against any SDK that are built. To enable this uncomment these lines.
        # See classes/test{image,sdk}.bbclass for further details.
        #IMAGE_CLASSES += "testimage testsdk"
        #TESTIMAGE_AUTO:qemuall = "1"
        
        #
        # Interactive shell configuration
        #
        # Under certain circumstances the system may need input from you and to do this it
        # can launch an interactive shell. It needs to do this since the build is
        # multithreaded and needs to be able to handle the case where more than one parallel
        # process may require the user's attention. The default is iterate over the available
        # terminal types to find one that works.
        #
        # Examples of the occasions this may happen are when resolving patches which cannot
        # be applied, to use the devshell or the kernel menuconfig
        #
        # Supported values are auto, gnome, xfce, rxvt, screen, konsole (KDE 3.x only), none
        # Note: currently, Konsole support only works for KDE 3.x due to the way
        # newer Konsole versions behave
        #OE_TERMINAL = "auto"
        # By default disable interactive patch resolution (tasks will just fail instead):
        PATCHRESOLVE = "noop"
        
        #
        # Disk Space Monitoring during the build
        #
        # Monitor the disk space during the build. If there is less that 1GB of space or less
        # than 100K inodes in any key build location (TMPDIR, DL_DIR, SSTATE_DIR), gracefully
        # shutdown the build. If there is less than 100MB or 1K inodes, perform a hard halt
        # of the build. The reason for this is that running completely out of space can corrupt
        # files and damages the build in ways which may not be easily recoverable.
        # It's necessary to monitor /tmp, if there is no space left the build will fail
        # with very exotic errors.
        BB_DISKMON_DIRS ??= "\
            STOPTASKS,${TMPDIR},1G,100K \
            STOPTASKS,${DL_DIR},1G,100K \
            STOPTASKS,${SSTATE_DIR},1G,100K \
            STOPTASKS,/tmp,100M,100K \
            HALT,${TMPDIR},100M,1K \
            HALT,${DL_DIR},100M,1K \
            HALT,${SSTATE_DIR},100M,1K \
            HALT,/tmp,10M,1K"
        
        #
        # Shared-state files from other locations
        #
        # As mentioned above, shared state files are prebuilt cache data objects which can be
        # used to accelerate build time. This variable can be used to configure the system
        # to search other mirror locations for these objects before it builds the data itself.
        #
        # This can be a filesystem directory, or a remote url such as https or ftp. These
        # would contain the sstate-cache results from previous builds (possibly from other
        # machines). This variable works like fetcher MIRRORS/PREMIRRORS and points to the
        # cache locations to check for the shared objects.
        # NOTE: if the mirror uses the same structure as SSTATE_DIR, you need to add PATH
        # at the end as shown in the examples below. This will be substituted with the
        # correct path within the directory structure.
        #SSTATE_MIRRORS ?= "\
        #file://.* https://someserver.tld/share/sstate/PATH;downloadfilename=PATH \
        #file://.* file:///some/local/dir/sstate/PATH"
        
        #
        # Yocto Project SState Mirror
        #
        # The Yocto Project has prebuilt artefacts available for its releases, you can enable
        # use of these by uncommenting the following lines. This will mean the build uses
        # the network to check for artefacts at the start of builds, which does slow it down
        # equally, it will also speed up the builds by not having to build things if they are
        # present in the cache. It assumes you can download something faster than you can build it
        # which will depend on your network.
        # Note: For this to work you also need hash-equivalence passthrough to the matching server
        #
        #BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
        #SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"
        
        #
        # Qemu configuration
        #
        # By default native qemu will build with a builtin VNC server where graphical output can be
        # seen. The line below enables the SDL UI frontend too.
        PACKAGECONFIG:append:pn-qemu-system-native = " sdl"
        # By default libsdl2-native will be built, if you want to use your host's libSDL instead of 
        # the minimal libsdl built by libsdl2-native then uncomment the ASSUME_PROVIDED line below.
        #ASSUME_PROVIDED += "libsdl2-native"
        
        # You can also enable the Gtk UI frontend, which takes somewhat longer to build, but adds
        # a handy set of menus for controlling the emulator.
        #PACKAGECONFIG:append:pn-qemu-system-native = " gtk+"
        
        #
        # Hash Equivalence
        #
        # Enable support for automatically running a local hash equivalence server and
        # instruct bitbake to use a hash equivalence aware signature generator. Hash
        # equivalence improves reuse of sstate by detecting when a given sstate
        # artifact can be reused as equivalent, even if the current task hash doesn't
        # match the one that generated the artifact.
        #
        # A shared hash equivalent server can be set with "<HOSTNAME>:<PORT>" format
        #
        #BB_HASHSERVE = "auto"
        #BB_SIGNATURE_HANDLER = "OEEquivHash"
        
        #
        # Memory Resident Bitbake
        #
        # Bitbake's server component can stay in memory after the UI for the current command
        # has completed. This means subsequent commands can run faster since there is no need
        # for bitbake to reload cache files and so on. Number is in seconds, after which the
        # server will shut down.
        #
        #BB_SERVER_TIMEOUT = "60"
        
        # CONF_VERSION is increased each time build/conf/ changes incompatibly and is used to
        # track the version of this file when it was generated. This can safely be ignored if
        # this doesn't mean anything to you.
        CONF_VERSION = "2"
        ENABLE_UART = "1"
        RPI_USE_U_BOOT = "1"
        ```
        
    
    Make sure your update to reactivate oe-init-build-env again
    
    ```jsx
    source ~/yocto/kirkstone/poky/oe-init-build-env ../**Projectname**
    ```
    
    1. Build
    
    ```jsx
    cd ~/yocto/kirkstone/Projectname
    bitbake core-image-minimal
    ```
    
    Now, you can see building.
    
    I don’t know the accurate time to build, but I’m sure it will takes more than 1 hour.
    
    So take a meal / rest / play game/ or do something.
    
    ![Screenshot from 2022-10-25 19-50-12.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8634f53e-fcb8-4116-aeb6-5ce1aaaf6cec/Screenshot_from_2022-10-25_19-50-12.png)
    

# Write on SD card

- Write on SD card
    
    ### After build, you can check your image on
    
    ~build diercotry/tmp/deploy/images/raspberrypi4/core-image-minimal-raspberrypi4-20221221163429.rootfs.wic.bz2
    
    1. Move wic.bz2 file to somewhere, In my case I move it to home directory.
    
    then, unzip it
    
    ```jsx
    sudo bzip2 -dk core-image-minimal-raspberrypi4-20221025172232.rootfs.wic.bz2
    ```
    
    1. Write on SD card
    
    insert sd card in USB port. Type this
    
    ```jsx
    sudo fdisk -l
    ```
    
    ```jsx
    umount /dev/sda
    ```
    
    go to the directory where you moved wic.bz2 file.
    
    Type this.
    
    ```jsx
    sudo dd if=core-image-minimal-raspberrypi4-20221128122747.rootfs.wic of=/dev/sda
    sync
    ```
    
    1. Efect and reinsert SD card, 
    
    Go to boot directory in your SDcard, and change config.txt
    
    ```jsx
    #dtoverlay vc4 kms어쩌구 저쩌구 이거 주석처리하셈
    
    located at 
    boot/config.txt
    ```
    
    ```jsx
    ## dtoverlay=vc4-kms-v3d
    to
    dtoverlay=vc4-fkms-v3d-pi4
    ```
    

# Add python

- Add python
    
    If you done previous step, It would not takes more than 10minutes to build.
    
    1. Add [image.bb](http://image.bb) file
    
    ```jsx
    cd ~/yocto/kirkstone/poky/meta/recipes-core/images
    ```
    
    1. Make new [image.bb](http://image.bb) file
    
    ```jsx
    core-image-python.bb
    ```
    
    - [core-image-python.bb](http://core-image-python.bb)
        
        (I only add
        
        **IMAGE_INSTALL += "python3 python3-numpy”** from core-image-minimal.bb )
        
        ```jsx
        SUMMARY = "A small image just capable of allowing a device to boot."
        
        IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
        IMAGE_INSTALL += "python3 python3-numpy"
        
        IMAGE_LINGUAS = " "
        
        LICENSE = "MIT"
        
        inherit core-image
        
        IMAGE_ROOTFS_SIZE ?= "8192"
        IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "", d)}"
        ```
        
    1. Build
    
    ```jsx
    cd ~/yocto/kirkstone/poky
    source oe-init-build-env ../raspberrypi4
    ```
    
    1. Add new layer at sd card
    
    Same with previous step
    

# Build QT exe (Only for example code)

- Build QT
    1. Download met-QT5
    
    ```jsx
    cd ~/yocto/kirkstone
    git clone -b kirkstone https://github.com/meta-qt5/meta-qt5
    ```
    
    1. Add new layer at local.conf , bblayers.conf
    
    ```jsx
    cd ~/yocto/kirkstone/**Projectname**/conf
    vim local.conf
    ```
    
    Add this line
    
    ```jsx
    CORE_IMAGE_EXTRA_INSTALL:append = "qtbase-examples"
    ```
    
    ```jsx
    vim bblayers.conf
    ```
    
    Add this line
    
    ```jsx
    /home/seame-fablab/yocto/kirkstone/meta-qt5 \
    ```
    
    1. Make .bbappend file
    
    ```jsx
    cd ~yocto/kirkstone/poky/meta-poky
    mkdir -p recipes-qt/qt5
    cd recipes-qt/qt5
    vim qtbase_%.bbappend
    ```
    
    Add this line
    
    ```jsx
    PACKAGECONFIG:append = " examples gles2 eglfs"
    PACKAGECONFIG:remove = "tslib"
    ```
    
    1. Build
    
    ```jsx
    cd ~/yocto/kirkstone/poky
    source oe-init-build-env ../raspberrypi4
    bitbake core-image-minimal
    ```
    
    1. Check example code
    
    ```jsx
    cd /usr/share/qt5/examples/opengl/hellowindow
    
    ./hellowindow -platform eglfs
    ```
    

# Build Custom QT file

- Build Custom Qt file
    1. Create custom layer
    
    ```jsx
    cd ~
    ```
    

# QT in Rpi (add exist layer)

- QT in Rpi
    
    ```jsx
    goto root
    usr/share/examples/opengl/hellowindow
    there are so many qt examples
    
    In my case, I use hellowindow
    
    ./hellowindow -platform eglfs
    ```
    
    ![Screenshot from 2022-11-28 15-40-10.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5c5ffc27-6a7e-48c5-892a-e9ca23cb750a/Screenshot_from_2022-11-28_15-40-10.png)
    
    this is original window
    
    ![Screenshot from 2022-11-28 15-40-18.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9e5d21a8-00cf-4c6c-ad92-70ca0de0d89c/Screenshot_from_2022-11-28_15-40-18.png)
    
    this is in root directory (which is in sd card)
    
    So, the difference is only for listnames.pro.user / listnames.exe
    
    location of ‘listname’ before bitbake.
    
    ![Screenshot from 2022-11-28 15-50-01.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7859f8af-c63a-40ee-a84c-2343cfebfc1f/Screenshot_from_2022-11-28_15-50-01.png)
    

# command

- where can i get bb file?
    
    ```jsx
    /yocto/kirkstone/poky/meta/recipes-core/images
    ```
    
    ```jsx
    # type this in terminal
    
    yocto/kirkstone/builds/raspberrypi4/tmp/work/raspberrypi4-poky-linux-gnueabi/core-image-minimal/1.0-r0/rootfs$ find . -name python3
    ```
    
- how can i add bbfile?
    
    ```jsx
    unsharp below
    
    SUMMARY = "A small image just capable of allowing a device to boot."
    
    IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
    
    IMAGE_LINGUAS = " "
    
    LICENSE = "MIT"
    
    inherit core-image
    
    IMAGE_ROOTFS_SIZE ?= "8192"
    IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "", d)}"
    
    # ybelow like this 
    # RDEPENDS_${PN}: = "python3 c++ QT "
    # use  init script file to autoexcute something file
    ```
    
- where is core-iamge.bbclass
    
    ```jsx
    ~yocto/kirkstone/poky/meta/classes/core-image.bbclass
    ```
    
- why the core-image-minimal doesnt work?
    
    ```jsx
    excute config.txt.sb-c2dfd18a-9XwQq6
    uncomment
    # Enable VC4 Graphics
    ```
    

# Make Custom Layer

- make custom layer
    1. Activate environment, what you are planning to add. 
    
    In my case, I want to add my custom layer at ‘raspberrypi4’ folder
    
    ```jsx
    source ~/yocto/kirkstone/poky/oe-init-build-env ~/yocto/kirkstone/builds/raspberrypi4
    ```
    
    1. go to directory address where you want to make custom layer
    
    In my case, I want to make directory at home/yocto/kirkstone
    
    `bitbake-layers create-layer meta-<layer_name>`
    
    ```jsx
    cd ~/yocto/kirkstone
    bitbake-layers create-layer meta-mylayer
    ```
    
    1. Add new layer
    
    ```jsx
    cd ~/yocto/kirkstone/builds/raspberrypi4/conf/bblayers.conf
    vim bbalyers.conf
    ```
    
    add this line
    
    ```jsx
    /home/seame-fablab/yocto/kirkstone/meta-mylayer \
    ```
    
    1. Write a new image recipe
    
    ```jsx
    cd ~/yocto/kirkstone//meta-mylayer
    mkdir -p recipes-core/images
    cd recipes-core/images
    ```
    
    ```jsx
    vim basic-qt5-image.bb
    ```
    
    ```jsx
    SUMMARY = "A basic Qt5 dev image"
    
    require recipes-core/images/core-image-minimal.bb 
    
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
        qtquickcontrols2 \
        qtquickcontrols2-dev \
        qtquickcontrols2-mkspecs \
        qtdeclarative \
        qtdeclarative-dev \
        qtdeclarative-mkspecs \
        qtgraphicaleffects \
        qtgraphicaleffects-dev \
    "
     
    IMAGE_INSTALL += " \
        ${QT_BASE} \
        ${QT_PKGS} \
    "
     
    export IMAGE_BASENAME = "basic-qt5-image"
    ```
    
    1. Write additional package recipe
    
    ```jsx
    cd ~/yocto/kirkstone/meta-mylayer/recipes-example/example
    mv example_0.1.bb qtbase_git.bbappend #change name from example_0.1 to qtbase
    vim qtbase_git.bbappend
    ```
    
    Edit bbappend to this:
    
    ```jsx
    SUMMARY = "bitbake-layers recipe"
    DESCRIPTION = "Recipe created by bitbake-layers"
    LICENSE = "MIT"
     
    PACKAGECONFIG_append = " eglfs fontconfig gles2"
    DEPENDS += "userland"
    ```
    
    1. Build
    
    ```jsx
    cd ~/yocto/kirkstone/builds/raspberrypi4
    source oe-init-build-env
    bitbake basic-qt5-image
    ```
    
    # Build SDK
    
    1. Edit basic-qt5-image.bb
    
    ```jsx
    cd ~/yocto/kirkstone/meta-mylayer/recipes-core/image
    vim basic-qt5-image.bb
    ```
    
    Add this line top of file:
    
    ```jsx
    inherit populate_sdk populate_sdk_qt5
    ```
    
    1. Edit local.config
    
    ```jsx
    cd ~/yocto/kirkstone/builds/raspberrypi4/conf
    vim local.conf
    ```
    
    Add this line:
    
    ```jsx
    DISTRO_FEATURES:remove = "x11 wayland vulkan"
    ```
    
    1. Build
    
    ```jsx
    cd ~/yocto/kirkstone/builds/raspberrypi4
    source oe-init-build-env
    bitbake basic-qt5-image
    bitbake basic-qt5-image -c populate_sdk
    ```
    

# Encountered Error

- Errors
    - Error message - `No space left on device ENOSPC`
        
        ```jsx
        seame-fablab@seamefablab-Precision-7550:~/yocto/kirkstone/builds/rpi$ bitbake core-image-minimal
        Traceback (most recent call last):
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/bin/bitbake", line 37, in <module>
            sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/main.py", line 378, in bitbake_main
            return ui_module.main(server_connection.connection, server_connection.events,
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/ui/knotty.py", line 415, in main
            params.updateToServer(server, os.environ.copy())
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/cookerdata.py", line 75, in updateToServer
            raise Exception("Unable to update the server configuration with local parameters: %s" % error)
        Exception: Unable to update the server configuration with local parameters: Traceback (most recent call last):
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/command.py", line 90, in runCommand
            result = command_method(self, commandline)
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/command.py", line 286, in updateConfig
            command.cooker.updateConfigOpts(options, environment, cmdline)
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/cooker.py", line 535, in updateConfigOpts
            self.reset()
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/cooker.py", line 1774, in reset
            self.initConfigurationData()
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/cooker.py", line 404, in initConfigurationData
            self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/bb/cooker.py", line 313, in add_filewatch
            watcher.add_watch(f, self.watchmask, quiet=False)
          File "/home/seame-fablab/yocto/kirkstone/poky/bitbake/lib/pyinotify.py", line 1888, in add_watch
            raise WatchManagerError(err, ret_)
        pyinotify.WatchManagerError: add_watch: cannot watch /home/seame-fablab/yocto/kirkstone/builds/rpi/conf WD=-1, Errno=No space left on device (ENOSPC)
        ```
        
        there was planty of spaces in laptop.
        
        so error was caused from `max_user_watches`
        
        It means the number of max directories that can laptop checks about the changes.
        
        you can check the number of max_user_watches using this command
        
        ```jsx
        ysctl -n fs.inotify.max_user_watches
        ```
        
        - solution
            
            This is because you need more max_user_watches. Type below to enhace your max_user_watches
            
            ```jsx
            sudo sysctl fs.inotify.max_user_watches=654622
            ```
            
    - Error message - `Set a MACHINE`
        
        ```jsx
        ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
            Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
            Following is the list of potential problems / advisories:
        
            Please set a MACHINE in your local.conf or environment
        
        or
        
        ERROR: ParseError at /home/seame-fablab/yocto/kirkstone/builds/rpi/conf/local.conf:39: unparsed line: 'MACHINE = raspberrypi4'
        ```
        
        - solution
            
            ```jsx
            #add MACHINE local.conf
            MACHINE = "raspberrypi4"
            
            ```
            
- Building OS in Poky
    
    input
    
    ```jsx
    bitbake-layers -h
    ```
    
    output
    
    ```jsx
    NOTE: Starting bitbake server...
    ERROR: No space left on device or exceeds fs.inotify.max_user_watches?
    ERROR: To check max_user_watches: sysctl -n fs.inotify.max_user_watches.
    ERROR: To modify max_user_watches: sysctl -n -w fs.inotify.max_user_watches=<value>.
    ERROR: Root privilege is required to modify max_user_watches.
    ```
    
- OE-Core Error
    
    ```jsx
    ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
        Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
        Following is the list of potential problems / advisories:
    
        DL_DIR uses ~ but Bitbake will not expand this, use an absolute path or variables.
    ```
    
    go to build directory
    
    In my case, I set machine for rpi so I moved to  `~/yocto/kirkstone/builds/rpi`
    
    open terminal in that directory and type this
    
    ```jsx
    touch conf/sanity.conf
    ```
