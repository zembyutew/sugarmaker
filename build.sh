# CLEAN
make distclean || echo clean
rm -f config.status

# BUILD
./autogen.sh
./configure CFLAGS="-Wall -O2 -fomit-frame-pointer"
make
strip -s sugarmaker

# CHECK STATIC
file sugarmaker | grep "dynamically linked"
