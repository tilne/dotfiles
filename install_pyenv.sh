#!/bin/bash

set -e

CLOBBER=false


syntax() {
  cat <<- EOF
install_pyenv.sh [-c]
  -c/--clobber    If ~/.pyenv already exists, remove it and and re-clone
EOF
}


parse_args() {
  while [ $# -gt 0 ] ; do
    case "$1" in
      --clobber|-c)
        CLOBBER=true
        ;;
      -h|--help|help)
        syntax
        exit 0
        ;;
      *)
        echo >&2 "Unrecognized option '$1'"
        syntax
        exit 1
        ;;
    esac
    shift
  done
}


install_pyenv() {
  local PYENV_GIT_URL=https://github.com/pyenv/pyenv.git
  local PYENV_ROOT="${HOME}"/.pyenv
  local VIRTUALENV_PLUGIN_DIR="${PYENV_ROOT}"/plugins/pyenv-virtualenv
  if [ -d "${PYENV_ROOT}" ]; then
    if [ -d "${PYENV_ROOT}/.git" ] && [ "$(git -C "${PYENV_ROOT}" remote get-url origin)" == "${PYENV_GIT_URL}" ]; then
      echo "${PYENV_ROOT} already contains a git repo where origin points to the expected URL."
    elif [ "${CLOBBER}" == "true" ]; then
      echo "Removing ${PYENV_ROOT} and replacing it with a newly cloned version."
      rm -rf "${PYENV_ROOT}"
      git clone "${PYENV_GIT_URL}" "${PYENV_ROOT}"
    else
      echo >&2 "${PYENV_ROOT} already exists and CLOBBER was not set."
      exit 1
    fi
  else
    git clone "${PYENV_GIT_URL}" "${PYENV_ROOT}"
  fi
  [ -d "${VIRTUALENV_PLUGIN_DIR}" ] || git clone https://github.com/pyenv/pyenv-virtualenv.git "${VIRTUALENV_PLUGIN_DIR}"
}


get_latest_pyenv_38_version() {
  pyenv install --list | grep -E '^\s+3.8' | tail -n1
}


create_develop_virtualenv() {
  local latest_38_version
  export PATH="${HOME}/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  if ! pyenv virtualenvs | grep -E &> /dev/null '\s+develop\s+'; then
    latest_38_version="$(get_latest_pyenv_38_version)"
    pyenv install "${latest_38_version}"
    pyenv virtualenv "${latest_38_version}" develop
  fi
  pyenv activate develop
  pip install -r requirements.txt  # assumes script is run from dotfiles dir
}


main() {
  parse_args "$@"
  install_pyenv
  create_develop_virtualenv
}

main "$@"
