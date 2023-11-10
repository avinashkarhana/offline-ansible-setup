# Offline Ansible Setup

Offline Ansible setup script for RHEL, CentOS, and Fedora.

- Can be used on locked down systems where internet access is not available, except yum repositories.

- All packages are downloaded from the official repositories and their checksums can be verified from the official repositories.

## Note

As of now this only supports RHEL, CentOS, and Fedora.
Basically Yum based installation only

## How to take these scripts to target machine

### Cloning this repo

1. Clone this repo on your local machine
2. Copy the repo to target machine using `scp` command

    `scp -r <path to repo> <username>@<ip address>:<path to destination>`

    Example:

        scp -r /home/user/ansible-offline-setup/ root@192.168.0.1:~/ansible-offline-setup/

### Download the repo as zip or zip it yourself after cloning

1. Get the ZIP ready
2. Copy the ZIP to target machine using `scp` command

        `scp <path to zip> <username>@<ip address>:/<path to destination>`

    Example:

        scp /home/user/ansible-offline-setup.zip root@192.168.0.1:~/ansible-offline-setup.zip

## Pre-requisite

    Python 3.9 or higher first. 
    - (If not present the script will try to install these by itself, if doesn't works, try installing yourself)

## Usage

1. Mark `setupAnsible.sh` as executable by running `chmod +x setupAnsible.sh`

2. Run `./setupAnsible.sh`
