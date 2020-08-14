#!/bin/bash

set -ex

# vim
cp -r vim ~/.vim
cp vimrc ~/.vimrc

# aliases
cp ~/aliases ~/.aliases

# bash
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# zsh
OH_MY_ZSH_HOME=${HOME}/.oh-my-zsh
[ -d ${OH_MY_ZSH_HOME} ] || git clone https://github.com/ohmyzsh/ohmyzsh ${OH_MY_ZSH_HOME}
cp zshrc ~/.zshrc

# python
PYENV_ROOT=${HOME}/.pyenv
VIRTUALENV_PLUGIN_DIR=${PYENV_ROOT}/plugins/pyenv-virtualenv
[ -d ${PYENV_ROOT} ] || git clone https://github.com/pyenv/pyenv ${PYENV_ROOT}
[ -d ${VIRTUALENV_PLUGIN_DIR} ] || git clone https://github.com/pyenv/pyenv-virtualenv.git ${VIRTUALENV_PLUGIN_DIR}
cp pythonrc ~/.pythonrc
