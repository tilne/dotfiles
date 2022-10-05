#!/bin/bash
set -e

CLOBBER=false

syntax() {
  cat <<- EOF
apply_configs.sh [-c]
  -c/--clobber    Remove and replace files that already exist
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


main() {
  parse_args "$@"
  CLOBBER_FLAG=""
  [ "${CLOBBER}" == "true" ] && CLOBBER_FLAG="--clobber"
  ./install_pyenv.sh ${CLOBBER_FLAG}
  ./install_nvm.sh
  pip install -r requirements.txt
  ./apply_configs.py ${CLOBBER_FLAG}
}

main "$@"
