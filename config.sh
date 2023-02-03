#!/bin/bash

#BIN_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# logging info
function log_info() {
    echo "[$(date)] [INFO]: $@"
}

# logging error
function log_error() {
    echo "[$(date)] [ERROR]: $@"
}

# install important packages
function install() {
    set -e 
    yum update -y
    yum -y install epel-release
    yum -y install ShellCheck python3 yum-utils
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    yum install code
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
    rpm -Uvh minikube-latest.x86_64.rpm
    pip3 install yamllint black
}

# starting services like docker and minikube
function start_services() {
    set -e 
    systemctl start docker
    chmod 666 /var/run/docker.sock
    minikube start --driver=docker
    alias kubectl="minikube kubectl --"
    alias vsc="code --user-data-dir --no-sandbox"
}

function vim_config() {
    set -e
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
}

function main() {
    if [ $(whoami) = "root" ]; then
        install

        if [ $? -eq 0 ]; then
            log_info "Services started sucessfuly!"
        else
            log_error "Error occurs during starting services!"
        fi

        start_services

        if [ $? -eq 0 ]; then
            log_info "Services started sucessfuly!"
        else
            log_error "Error occurs during starting services!"
        fi

    else
        sudo su

        install

        if [ $? -eq 0 ]; then
            log_info "Services started sucessfuly!"
        else
            log_error "Error occurs during starting services!"
        fi
        
        start_services

        if [ $? -eq 0 ]; then
            log_info "Services started sucessfuly!"
        else
            log_error "Error occurs during starting services!"
        fi
    fi


    vim_config

    if [ $? -eq 0 ]; then
        log_info "Vim configured succesfully!"
    else   
        log_erroe "Error occurs during configuration!"
    fi
}

main
