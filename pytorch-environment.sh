#!/bin/bash

# 检查当前用户是否为root
if [[ $EUID -ne 0 ]]; then
    echo "当前用户不是root用户，正在获取sudo权限。"
    if ! command -v sudo >/dev/null 2>&1; then
        echo "sudo命令未找到，请确保安装了sudo工具。"
        exit 1
    fi
    sudo_cmd="sudo"
else
    echo "当前用户是root用户。"
    sudo_cmd=""
fi

$sudo_cmd apt update

if command -v python3.10 &>/dev/null; then
    echo "python3.10已安装"
else
    echo "安装python3.10"
    $sudo_cmd apt install python3.10
    echo "python3.10安装成功"
fi

if command -v conda >/dev/null 2>&1; then
    echo "Miniconda已安装。"
else
    echo "安装Miniconda。"
    wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.5.2-0-Linux-x86_64.sh
    echo -e "\nyes\n\nyes" | bash Miniconda3-py310_23.5.2-0-Linux-x86_64.sh
    rm Miniconda3-py310_23.5.2-0-Linux-x86_64.sh
    echo "Miniconda安装成功。"
fi

echo "退出终端，重新进入终端后再次运行这个脚本。"
pip install jupyter torch torchvision
