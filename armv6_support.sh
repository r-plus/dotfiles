#!/bin/sh

Xcode='/Applications/Xcode.app'
Xcode4='/Applications/Xcode4.4.1.app'

### libclang_rt.ios.a
# Supposition: contain only one clang version.
cd $Xcode/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/*/lib/darwin/
sudo mv libclang_rt.ios.a libclang_rt.ios.latest.a
sudo lipo -thin armv6 -output libclang_rt.ios.armv6.a $Xcode4/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/4.0/lib/darwin/libclang_rt.ios.a
sudo lipo -create -output libclang_rt.ios.a libclang_rt.ios.armv6.a libclang_rt.ios.latest.a
[ $(lipo -info libclang_rt.ios.a | grep -wc armv6) -ne 0 ] && echo "libclang_rt [ Success ]" || echo "libclang_rt [ Failed ]"

### dylib1.o
# Supposition: contain only one sdk.
#cd $(xcrun --show-sdk-path --sdk iphoneos)/usr/lib
cd $Xcode/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS*.sdk
sudo mv dylib1.o dylib1.latest.o
sudo lipo -thin armv6 -output dylib1.armv6.o $Xcode4/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/usr/lib/dylib1.o
sudo lipo -create -output dylib1.o dylib1.armv6.o dylib1.latest.o
[ $(lipo -info dylib1.o | grep -wc armv6) -ne 0 ] && echo "dylib1.o [ Success ]" || echo "dylib1.o [ Failed ]"
