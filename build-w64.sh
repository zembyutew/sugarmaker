# CLEAN
make distclean || echo clean

# BUILD
./autogen.sh

LDFLAGS="-L./depends/curl-7.40.0-devel-mingw64/lib64 -static" LIBCURL="-lcurldll" CFLAGS="-Wall -O2 -fomit-frame-pointer" ./configure --host=x86_64-w64-mingw32 --with-curl=depends/curl-7.40.0-devel-mingw64

make

strip -p --strip-debug --strip-unneeded sugarmaker.exe

# PACKAGE
RELEASE=sugarmaker-v2.5.0-sugar1-w64
rm -rf $RELEASE
mkdir $RELEASE

cp ./depends/curl-7.40.0-devel-mingw64/bin/libcurl.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw64/bin/libeay32.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw64/bin/ssleay32.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw64/bin/zlib1.dll $RELEASE/
cp ./depends/bat/*.bat $RELEASE/
mv sugarmaker.exe $RELEASE/

# SIGN
zip -X $RELEASE/$RELEASE.zip $RELEASE/*
sha256sum $RELEASE/$RELEASE.zip > $RELEASE/$RELEASE
gpg --digest-algo sha256 --clearsign $RELEASE/$RELEASE
rm $RELEASE/$RELEASE && cat $RELEASE/$RELEASE.asc
