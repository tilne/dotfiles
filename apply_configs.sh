#!/bin/bash

set -ex

# It's assumed that this script will be run from the top-level repo directory
REPO_DIR="$(pwd)"
# TODO: currently the script fails if a file already exists at the path where it's
#       attempting to create a link. it would be better if the script could not fail
#       when the file it finds is a link that points back to the correct source.

# vim
ln -s "${REPO_DIR}"/vim ~/.vim
ln -s "${REPO_DIR}"/vimrc ~/.vimrc
VUNDLE_DIR="${HOME}"/.vim/bundle/Vundle.vim
[ -d "${VUNDLE_DIR}" ] || git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"

# aliases
ln -s "${REPO_DIR}"/aliases ~/.aliases

# bash
ln -s "${REPO_DIR}"/bashrc ~/.bashrc
ln -s "${REPO_DIR}"/bash_profile ~/.bash_profile

# zsh
OH_MY_ZSH_HOME="${HOME}"/.oh-my-zsh
[ -d "${OH_MY_ZSH_HOME}" ] || git clone https://github.com/ohmyzsh/ohmyzsh "${OH_MY_ZSH_HOME}"
ln -s "${REPO_DIR}"/zshrc ~/.zshrc

# python
PYENV_ROOT="${HOME}"/.pyenv
VIRTUALENV_PLUGIN_DIR="${PYENV_ROOT}"/plugins/pyenv-virtualenv
[ -d "${PYENV_ROOT}" ] || git clone https://github.com/pyenv/pyenv "${PYENV_ROOT}"
[ -d "${VIRTUALENV_PLUGIN_DIR}" ] || git clone https://github.com/pyenv/pyenv-virtualenv.git "${VIRTUALENV_PLUGIN_DIR}"
ln -s "${REPO_DIR}"/pythonrc ~/.pythonrc

# emacs
ln -s "${REPO_DIR}"/emacs ~/.emacs
ESHELL_DIR="${HOME}"/.emacs.d/eshell
[ -d "${ESHELL_DIR}" ] || mkdir -p "${ESHELL_DIR}"
ln -s "${REPO_DIR}"/eshell-profile "${ESHELL_DIR}"/profile

# tmux
ln -s "${REPO_DIR}"/tmux.conf ~/.tmux.conf

# script for editing status reports
LOCAL_BIN=~/bin
[ -d "${LOCAL_BIN}" ] || mkdir -p "${LOCAL_BIN}"
ln -s "${REPO_DIR}"/status.py "${LOCAL_BIN}"

# alacritty
ALACRITTY_CONFIG_DIR="${HOME}"/.config/alacritty
[ -d "${ALACRITTY_CONFIG_DIR}" ] || mkdir -p "${ALACRITTY_CONFIG_DIR}"
ln -s "${REPO_DIR}"/alacritty.yml "${ALACRITTY_CONFIG_DIR}"
