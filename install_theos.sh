#!/bin/bash

THEOS_INSTALL_DIR="/opt"
THEOS=${THEOS_INSTALL_DIR}/theos
BIGBOSS_REPO="http://apt.thebigboss.org/repofiles/cydia"
SUBSTRATE_REPO="http://apt.saurik.com"

if [ "$(pwd | grep travis)" ]; then
    echo "This is travis."
    THEOS_INSTALL_DIR=$(pwd)
    THEOS=${THEOS_INSTALL_DIR}/theos
fi

# initial theos install directory check
if [ ! -d "$THEOS_INSTALL_DIR" ]; then
    echo "making $THEOS_INSTALL_DIR"
    sudo mkdir -p $THEOS_INSTALL_DIR
fi

install_from_telesphoreo() {
    cd /tmp
    echo "Downloading substrate header and library..."
    if [ -z "$(find TelesphoreoPackages.bz2 -mmin -60)" ]; then
        rm -f TelesphoreoPackages.bz2
        curl -s -L "${SUBSTRATE_REPO}/dists/tangelo-3.7/main/binary-iphoneos-arm/Packages.bz2" > TelesphoreoPackages.bz2
    fi
    pkg_path=$(bzcat TelesphoreoPackages.bz2 | grep "debs/$1" | awk '{print $2}')
    pkg=$(basename $pkg_path)
    curl -s -L "${SUBSTRATE_REPO}/${pkg_path}" > $pkg
    if [ "$1" == "mobilesubstrate" ]; then
        ar -p $pkg data.tar.lzma | tar -Jxf - ./Library/Frameworks/CydiaSubstrate.framework
        mv ./Library/Frameworks/CydiaSubstrate.framework/Headers/CydiaSubstrate.h $THEOS/include/substrate.h
        mv ./Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate  $THEOS/lib/libsubstrate.dylib
        rm -rf $pkg /tmp/Library
    elif [ "$1" == "ldid" ]; then
        ar -p $pkg data.tar.gz | tar -zxvf- --strip-components 2 ./usr/bin/ldid
        mv bin/ldid $THEOS/bin
        rmdir bin
        rm -f $pkg
    fi
}

install_theos() {
    # clone theos.git
    cd $THEOS_INSTALL_DIR
    sudo git clone git://github.com/DHowett/theos.git
    sudo chown -R $USER $THEOS

    # clone iphoneheaders.git
    cd $THEOS
    mv include include.bak
    git clone git://github.com/r-plus/iphoneheaders.git include
    cp -a include.bak/* include
    rm -fr include.bak

    # get IOSurfaceAPI.h
    cd $THEOS/include/IOSurface
    find /System -name "IOSurfaceAPI.h" 2>/dev/null | xargs -J % cp % $THEOS/include/IOSurface/
    sed -i .orig -e 's/xpc_object_t/id/g' IOSurfaceAPI.h

    # clone CaptainHook.git
    cd $THEOS/include/
    git clone git://github.com/rpetrich/CaptainHook.git

    # clone theos-nic-templates.git
    cd $THEOS/templates/
    git clone git://github.com/orikad/theos-nic-templates.git

    # get flipswitch nic template
    cd /tmp
    git clone git://github.com/a3tweaks/Flipswitch.git
    cd "Flipswitch/NIC Template"
    cp iphone_flipswitch_switch.nic.tar $THEOS/templates/iphone_flipswitch/

    # get ldid (Packages list is not latest for ldid)
    #install_from_telesphoreo ldid
    cd $THEOS
    curl -s -L http://apt.saurik.com/debs/ldid_1:1.1.2_iphoneos-arm.deb > ldid.deb
    ar -p ldid.deb data.tar.gz | tar -zxvf- --strip-components 2 ./usr/bin/ldid
    rm ldid.deb

    # get dpkg for Mac OS X
    # `brew install dpkg`
    if [ -z $(type -P dpkg) ]; then
        echo "Should install dpkg"
        exit 1
    fi
}

install_library_from_bigboss() {
    cd /tmp
    echo "Downloading $1 /usr directory..."
    if [ -z "$(find BigBossPackages.bz2 -mmin -60)" ]; then
        rm -f BigBossPackages.bz2
        curl -s -L "${BIGBOSS_REPO}/dists/stable/main/binary-iphoneos-arm/Packages.bz2" > BigBossPackages.bz2
    fi
    pkg_path=$(bzcat BigBossPackages.bz2 | grep "debs2.0/$1" | awk '{print $2}')
    pkg=$(basename $pkg_path)
    curl -s -L "${BIGBOSS_REPO}/${pkg_path}" > $pkg
    data=$(ar -t $pkg | grep data.tar)
    ar -p $pkg $data | tar -zxf - ./usr
    cp -a ./usr/ $THEOS/
    rm -rf usr $pkg
}

re_install_all_libraries() {
    install_from_telesphoreo mobilesubstrate
    install_library_from_bigboss libactivator
    install_library_from_bigboss actionmenu_
    install_library_from_bigboss layersnapshotter
    install_library_from_bigboss libinstabanner
    install_library_from_bigboss applist
    install_library_from_bigboss preferenceloader
    install_library_from_bigboss com.a3tweaks.flipswitch
    install_library_from_bigboss libobjcipc
}

substitude_theos_in_dropbox() {
    for i in $(find ~/Dropbox -name "theos" -type d); do
        TWEAK_DIR=$(dirname $i)
        rm -fr $i
        ln -s $THEOS $i
    done
}

if [ $# -eq 0 ]; then
    install_theos
    re_install_all_libraries
else
    for i in $@; do
        install_library_from_bigboss $i
    done
fi

echo "Done."
# vim: set ts=4 sw=4 sts=4 expandtab:
