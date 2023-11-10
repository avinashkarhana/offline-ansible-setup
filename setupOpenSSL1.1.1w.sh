sudo yum -y update
sudo yum install -y make gcc perl-core pcre-devel wget zlib-devel
CURRENT_PATH=$(pwd)
cd deps
tar xvf openssl-1.1.1w.tar.gz
cd openssl-1.1*/
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make -j $(nproc)
sudo make install
sudo ldconfig
sudo tee -a /etc/profile.d/openssl.sh <<EOF
export PATH=/usr/local/openssl/bin:$PATH
EOF

sudo tee -a /etc/profile.d/sh.local <<EOF
if [ -z "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH
else
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
fi
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH
EOF

if [ -z "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$LD_LIBRARY_PATH
else
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
fi
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH

openssl version
cd $CURRENT_PATH
