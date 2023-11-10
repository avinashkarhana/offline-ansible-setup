MINIMUM_OPENSSL_VERSION="1.1.1"
CURRENT_OPENSSL_VERSION=$(openssl version 2>&1 | cut -d' ' -f2 | tr -cd '[:digit:].')

OPENSSL_VERSION_SATISFIED="0"

printf -v versions '%s\n%s' "$CURRENT_OPENSSL_VERSION" "$MINIMUM_OPENSSL_VERSION"
if [[ $versions = "$(sort -V <<< "$versions")" ]]; then
    if [ "$CURRENT_OPENSSL_VERSION" == "$MINIMUM_OPENSSL_VERSION" ]; then
        OPENSSL_VERSION_SATISFIED="1";
    else
        OPENSSL_VERSION_SATISFIED="0"
    fi
else
    OPENSSL_VERSION_SATISFIED="1"
fi

if [ "$OPENSSL_VERSION_SATISFIED" != "1" ]; then
    echo -e "\n## OpenSSL 1.1.1 or higher required !"
    echo -e "\nGoing to Installing OpenSSL 1.1.1w ......"
    ./setupOpenSSL1.1.1w.sh
fi

OPEN_SSL_PATH="/usr/local/openssl"
OPEN_SSL_LIB_PATH="/usr/local/openssl/lib"
if [ "$OPENSSL_VERSION_SATISFIED" == "1" ]; then
    echo -e "\n## OpenSSL 1.1.1 or higher is already installed ....\n"
    echo -e "\n## Please try finding out your OpenSSL Paths, usually you can find it by running:"
    echo -e "          which openssl"
    echo -e "          whereis openssl"
    echo -e "## OpenSSL path is the one that conatins"
    echo -e "          directories like bin, certs, include, and lib"
    echo -e "          files like ct_log_list.cnf and openssl.cnf"
    echo -e "## OpenSSL Library path is usually is that lib folder in side the OpenSSL path\n"
    read -p "Enter OpenSSL Path like(/usr/local/openssl): " OPEN_SSL_PATH
    read -p "Enter OpenSSL LibraryPath like(/usr/local/openssl/lib): " OPEN_SSL_LIB_PATH
fi

sudo yum -y update
sudo yum install wget make cmake gcc bzip2-devel libffi-devel zlib-devel
CURRENT_PATH=$(pwd)
cd deps
tar xvf Python-3.11.4.tgz
cd Python-3.11*/
LDFLAGS="${LDFLAGS} -Wl,-rpath=${OPEN_SSL_LIB_PATH}" ./configure --with-openssl=${OPEN_SSL_PATH}
make
sudo make altinstall
sudo ln -s /usr/local/bin/python3.11 /usr/bin/python3
cd $CURRENT_PATH
