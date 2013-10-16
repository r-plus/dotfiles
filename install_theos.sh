#!/bin/bash

THEOS_INSTALL_DIR="/opt"
THEOS=${THEOS_INSTALL_DIR}/theos
BIGBOSS_REPO="http://apt.thebigboss.org/repofiles/cydia"
SUBSTRATE_REPO="http://apt.saurik.com"

if $TRAVIS; then
    THEOS_INSTALL_DIR=$(pwd)
fi

# initial theos install directory check
if [ ! -d "$THEOS_INSTALL_DIR" ]; then
    echo "making $THEOS_INSTALL_DIR"
    sudo mkdir -p $THEOS_INSTALL_DIR
fi

install_theos() {
    # clone theos.git
    cd $THEOS_INSTALL_DIR
    sudo git clone git://github.com/DHowett/theos.git
    sudo chown $USER $THEOS

    # clone iphoneheaders.git
    cd $THEOS
    mv include include.bak
    git clone git://github.com/rpetrich/iphoneheaders.git include
    for FILE in include.bak/*.h; do mv $FILE include/; done
    rmdir include.bak/

    # get IOSurfaceAPI.h
    find /System -name "IOSurfaceAPI.h" 2>/dev/null | xargs -J % cp % $THEOS/include/IOSurface/

    # clone CaptainHook.git
    cd $THEOS/include/
    git clone git://github.com/rpetrich/CaptainHook.git

    # clone theos-nic-templates.git
    cd $THEOS/templates/
    git clone git://github.com/orikad/theos-nic-templates.git

    # get ldid for Mac OS X
    cd $THEOS/bin
    curl -O http://dl.dropbox.com/u/3157793/ldid
    chmod a+x ldid

    # get dpkg for Mac OS X
    # `brew install dpkg`
    if [ -z $(type -P dpkg) ]; then
        echo "Should install dpkg"
        exit 1
    fi
}

install_substrate() {
    cd /tmp
    echo "Downloading substrate header and library..."
    curl -s -L "${SUBSTRATE_REPO}/dists/tangelo-3.7/main/binary-iphoneos-arm/Packages.bz2" > Packages.bz2
    pkg_path=$(bzcat Packages.bz2 | grep "debs/mobilesubstrate" | awk '{print $2}')
    pkg=$(basename $pkg_path)
    curl -s -L "${SUBSTRATE_REPO}/${pkg_path}" > $pkg
    ar -p $pkg data.tar.gz | tar -zxf - ./Library/Frameworks/CydiaSubstrate.framework
    mv ./Library/Frameworks/CydiaSubstrate.framework/Headers/CydiaSubstrate.h $THEOS/include/substrate.h
    mv ./Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate  $THEOS/lib/libsubstrate.dylib
    rm -rf Packages.bz2 $pkg /tmp/Library
}

install_library_from_bigboss() {
    cd /tmp
    echo "Downloading $1 /usr directory..."
    curl -s -L "${BIGBOSS_REPO}/dists/stable/main/binary-iphoneos-arm/Packages.bz2" > Packages.bz2
    pkg_path=$(bzcat Packages.bz2 | grep "debs2.0/$1" | awk '{print $2}')
    pkg=$(basename $pkg_path)
    curl -s -L "${BIGBOSS_REPO}/${pkg_path}" > $pkg
    ar -p $pkg data.tar.gz | tar -zxf - ./usr
    cp -a ./usr/ $THEOS/
    rm -rf usr Packages.bz2 $pkg
}

re_install_all_libraries() {
    install_substrate
    install_library_from_bigboss libactivator
    install_library_from_bigboss actionmenu_
    install_library_from_bigboss layersnapshotter
    install_library_from_bigboss libinstabanner
    install_library_from_bigboss applist
    install_library_from_bigboss preferenceloader
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
