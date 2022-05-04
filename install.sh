#!/bin/bash

BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ ! -f $HOME/.vimrc ]]; then
  cat > $HOME/.vimrc << EOF
source $BASE_PATH/vimrc
EOF
fi

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

function GIT_CLONE_UPDATE()
{
  TARGET_DIR=$1
  GIT_REPO=$2

  if [[ ! -d ${TARGET_DIR} ]]; then
    git clone ${GIT_REPO} ${TARGET_DIR}
  fi

  (cd ${TARGET_DIR} && git pull)
}

DART_DIR="${BASE_PATH}/pack/dart/start/dart-vim-plugin"
DART_GIT_REPO=https://github.com/dart-lang/dart-vim-plugin.git
GIT_CLONE_UPDATE ${DART_DIR} ${DART_GIT_REPO}

CSHARP_DIR="${BASE_PATH}/pack/plugin/start/omnisharp-vim"
CSHARP_GIT_REPO=git@github.com:OmniSharp/omnisharp-vim.git
GIT_CLONE_UPDATE ${CSHARP_DIR} ${CSHARP_GIT_REPO}
vim +OmniSharpInstall +qall

NERDTREE_DIR="${BASE_PATH}/pack/plugin/start/nerdtree"
NERDTREE_GIT_REPO=git@github.com:preservim/nerdtree.git
GIT_CLONE_UPDATE ${NERDTREE_DIR} ${NERDTREE_GIT_REPO}
