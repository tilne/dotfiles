#!/bin/bash
set -o emacs
export LSCOLORS='fxfxcxdxgxegedabagacad'
export PS1='\[\e[32m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[32m\]\W\[\e[32m\]> \[\e[0m\]'
source ~/.aliases
export EDITOR="vim"
export PATH="/usr/local/bin:$PATH:/usr/local/mysql/bin:."
export SOUND_FILES_DIR='/System/Library/PrivateFrameworks/ScreenReader.framework/Versions/A/Resources/Sounds'
export TMPDIR='/tmp'
export PYTHONSTARTUP="/Users/tlane/.pythonrc"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/Users/tlane/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/Users/tlane/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/Users/tlane/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/Users/tlane/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/Users/tlane/perl5"
export EDITOR="vim"
export PATH="/usr/local/bin:$PATH:/usr/local/mysql/bin:."
export SOUND_FILES_DIR='/System/Library/PrivateFrameworks/ScreenReader.framework/Versions/A/Resources/Sounds'
export TMPDIR='/tmp'
export PYTHONSTARTUP="/Users/tlane/.pythonrc"
# Load RVM into a shell session *as a function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
module() {
    eval `$(which modulecmd) bash $*`
}
export MODULE_VERSION=$(modulecmd 2>&1 sh -V | egrep -o '\d+\.\d+\.\d+')
source /usr/local/Cellar/modules/$MODULE_VERSION/init/sh
export MODULEPATH=$MODULEPATH:${HOME}/modules
# Check if AD password is set to expire soon
# Only do so if on cray network
if ping &> /dev/null -c 1 stplcs01
then
    DAYS_UNTIL_PW_EXP=$(days_until_ad_password_exp)
    if [[ $DAYS_UNTIL_PW_EXP -le 10 ]]
    then
        echo "AD password will expire soon. Change it."
    fi
fi
clear
