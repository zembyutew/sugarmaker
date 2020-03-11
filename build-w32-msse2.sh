# CLEAN
make distclean || echo clean
rm -f config.status

# BUILD
./autogen.sh

LDFLAGS="-L./depends/curl-7.40.0-devel-mingw32/lib -static" LIBCURL="-lcurldll" CFLAGS="-Wall -O2 -fomit-frame-pointer -msse2" ./configure --host=i686-w64-mingw32 --with-curl=depends/curl-7.40.0-devel-mingw32

make

strip -p --strip-debug --strip-unneeded sugarmaker.exe

# PACKAGE
RELEASE=sugarmaker-v2.5.0-sugar1-w32-msse2
rm -rf $RELEASE
mkdir $RELEASE

cp ./depends/curl-7.40.0-devel-mingw32/bin/libcurl.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw32/bin/libeay32.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw32/bin/ssleay32.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw32/bin/zlib1.dll $RELEASE/
cp ./depends/curl-7.40.0-devel-mingw32/bin/libidn-11.dll $RELEASE/
# cp ./depends/curl-7.40.0-devel-mingw32/bin/* $RELEASE/
cp ./depends/bat/*.bat $RELEASE/
mv sugarmaker.exe $RELEASE/

# SIGN
zip -X $RELEASE/$RELEASE.zip $RELEASE/*
sha256sum $RELEASE/$RELEASE.zip > $RELEASE/$RELEASE
gpg --digest-algo sha256 --clearsign $RELEASE/$RELEASE
rm $RELEASE/$RELEASE && cat $RELEASE/$RELEASE.asc
