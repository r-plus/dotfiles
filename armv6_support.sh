#!/bin/sh

Xcode='/Applications/Xcode.app'
Xcode4='/Applications/Xcode4.4.1.app'
# Xcode 4.4.1 download from https://developer.apple.com/downloads/index.action?q=xcode%204.4.1

combine_armv6()
{
    if [ "$1" = "libclang_rt.ios.a" ]; then 
        # Supposition: contain only one clang version.
        cd $Xcode/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/*/lib/darwin/
        armv6_object="$Xcode4/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/4.0/lib/darwin/libclang_rt.ios.a"
    elif [ "$1" = "dylib1.o" ]; then
        # Supposition: contain only one sdk.
        cd $Xcode/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS*.sdk
        armv6_object="$Xcode4/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/usr/lib/dylib1.o"
    else
        echo "Not support"
        exit 1
    fi
    sudo mv $1 $1.latest
    sudo lipo -thin armv6 -output $1.armv6 $armv6_object
    sudo lipo -create -output $1 $1.armv6 $1.latest
    [ $(lipo -info $1 | grep -wc armv6) -ne 0 ] && echo "$1 [ Success ]" || echo "$1 [ Failed ]"
}

### libclang_rt.ios.a
combine_armv6 libclang_rt.ios.a

### dylib1.o
combine_armv6 dylib1.o
