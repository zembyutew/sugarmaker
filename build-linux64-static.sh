# CLEAN
make distclean || echo clean
rm -f config.status

# BUILD
./autogen.sh
CFLAGS="-Wall -O2 -fomit-frame-pointer" CXXFLAGS="$CFLAGS -std=gnu++11" LDFLAGS="-static" ./configure --with-curl=/usr/local/
make
strip -s sugarmaker

# CHECK STATIC
file sugarmaker | grep "statically linked"

# PACKAGE
RELEASE=sugarmaker-v2.5.0-sugar1-linux64-static
rm -rf $RELEASE
mkdir $RELEASE
cp sugarmaker $RELEASE/

# SIGN
zip -X $RELEASE/$RELEASE.zip $RELEASE/*
sha256sum $RELEASE/$RELEASE.zip > $RELEASE/$RELEASE
gpg --digest-algo sha256 --clearsign $RELEASE/$RELEASE
rm $RELEASE/$RELEASE && cat $RELEASE/$RELEASE.asc
