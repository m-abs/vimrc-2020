#!/bin/bash

BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $BASE_PATH

COC_DIR="${BASE_PATH}/pack/coc/start"
if [[ ! -d "${COC_DIR}/coc.nvim-release" ]]; then
  (
    mkdir -pv ${COC_DIR}
    cd $_

    curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -
  )
fi

LOCAL_START="${BASE_PATH}/pack/local/start"

EDITORCONFIG_PATH="${LOCAL_START}/editorconfig-vim"
if [[ ! -d $EDITORCONFIG_PATH ]]; then
  (
     EDITORCONFIG_VERSION=1.1.1
     mkdir -pv $EDITORCONFIG_PATH
     cd $_

     wget https://github.com/editorconfig/editorconfig-vim/releases/download/v${EDITORCONFIG_VERSION}/editorconfig-vim-minimal-v${EDITORCONFIG_VERSION}.zip
     unzip editorconfig-vim-minimal-v${EDITORCONFIG_VERSION}.zip && rm -v $_
  )
fi

DART_DIR="${BASE_PATH}/pack/dart/start/dart-vim-plugin"
if [[ ! -d ${DART_DIR} ]]; then
  git clone https://github.com/dart-lang/dart-vim-plugin.git ${DART_DIR}
fi
