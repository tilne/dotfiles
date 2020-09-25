#!/bin/bash

set -ex

# vim
cp -r vim ~/.vim
cp vimrc ~/.vimrc
VUNDLE_DIR="${HOME}"/.vim/bundle/Vundle.vim
[ -d "${VUNDLE_DIR}" ] || git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"

# aliases
cp ./aliases ~/.aliases

# bash
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# zsh
OH_MY_ZSH_HOME="${HOME}"/.oh-my-zsh
[ -d "${OH_MY_ZSH_HOME}" ] || git clone https://github.com/ohmyzsh/ohmyzsh "${OH_MY_ZSH_HOME}"
cp zshrc ~/.zshrc

# python
PYENV_ROOT="${HOME}"/.pyenv
VIRTUALENV_PLUGIN_DIR="${PYENV_ROOT}"/plugins/pyenv-virtualenv
[ -d "${PYENV_ROOT}" ] || git clone https://github.com/pyenv/pyenv "${PYENV_ROOT}"
[ -d "${VIRTUALENV_PLUGIN_DIR}" ] || git clone https://github.com/pyenv/pyenv-virtualenv.git "${VIRTUALENV_PLUGIN_DIR}"
cp pythonrc ~/.pythonrc

# emacs
cp ./emacs ~/.emacs
EMACS_DIR="${HOME}"/.emacs.d
ESHELL_DIR="${EMACS_DIR}"/eshell
cp ./eshell-profile "${ESHELL_DIR}"/profile

# tmux
cp ./tmux.conf ~/.tmux.conf

# script for editing status reports
LOCAL_BIN=~/bin
[ -d "${LOCAL_BIN}" ] || mkdir -p "${LOCAL_BIN}"
cp ./status.py "${LOCAL_BIN}"
