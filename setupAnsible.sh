MINIMUM_PYTHON_VERSION="3.9"
CURRENT_PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2 | tr -cd '[:digit:].')

PYTHON_VERSION_SATISFIED="0"

printf -v versions '%s\n%s' "$CURRENT_PYTHON_VERSION" "$MINIMUM_PYTHON_VERSION"
if [[ $versions = "$(sort -V <<< "$versions")" ]]; then
    if [ "$CURRENT_PYTHON_VERSION" == "$MINIMUM_PYTHON_VERSION" ]; then
        PYTHON_VERSION_SATISFIED="1";
    else
        PYTHON_VERSION_SATISFIED="0"
    fi
else
    PYTHON_VERSION_SATISFIED="1"
fi

if [ "$PYTHON_VERSION_SATISFIED" != "1" ]; then
    echo "## Python 3.9 or above is required !"
    echo "Going to Installing Python 3.11.4 ......"
    ./setupPython3.11.4.sh
fi

# Get the current directory
CURRENT_DIR=$(pwd)

# Install Python packages
python3 -m pip install --upgrade --force-reinstall --find-links "$CURRENT_DIR/deps/" --no-index --user "$CURRENT_DIR/deps/ansible-8.6.1-py3-none-any.whl"
python3 -m pip install --upgrade --force-reinstall --find-links "$CURRENT_DIR/deps/" --no-index --user "$CURRENT_DIR/deps/python_dateutil-2.8.2-py2.py3-none-any.whl"
python3 -m pip install --upgrade --force-reinstall --find-links "$CURRENT_DIR/deps/" --no-index --user "$CURRENT_DIR/deps/pywinrm-0.4.3-py2.py3-none-any.whl"
python3 -m pip install --upgrade --force-reinstall --find-links "$CURRENT_DIR/deps/" --no-index --user "$CURRENT_DIR/deps/requests-2.31.0-py3-none-any.whl"

echo "export PATH=~/.local/bin/:$PATH" >> .bashrc

# Install Ansible Galaxy collection
ansible-galaxy collection install "$CURRENT_DIR/deps/ansible-windows-2.1.0.tar.gz"
