# CLEAN
make distclean || echo clean
rm -f config.status

# DEPS
# cd deps
# ./build_win_x64_deps.sh
# cd ..

# BUILD
autoreconf -fi -I./deps/x86_64-w64-mingw32/share/aclocal
./autogen.sh
./configure --host=x86_64-w64-mingw32 LDFLAGS="-L./deps/x86_64-w64-mingw32/lib -static" CFLAGS="-Wall -O2 -fomit-frame-pointer -I./deps/x86_64-w64-mingw32/include -std=c99 -DWIN32 -DCURL_STATICLIB -DPTW32_STATIC_LIB" --with-libcurl=deps/x86_64-w64-mingw32
make
strip -p --strip-debug --strip-unneeded sugarmaker.exe

# PACKAGE
RELEASE=sugarmaker-v2.5.0-sugar1-w64-static
rm -rf $RELEASE
mkdir $RELEASE

cp ./depends/bat/*.bat $RELEASE/
mv sugarmaker.exe $RELEASE/

# SIGN
zip -X $RELEASE/$RELEASE.zip $RELEASE/*
sha256sum $RELEASE/$RELEASE.zip > $RELEASE/$RELEASE
gpg --digest-algo sha256 --clearsign $RELEASE/$RELEASE
rm $RELEASE/$RELEASE && cat $RELEASE/$RELEASE.asc
