#!/bin/bash

node_js:
    - '6'

cache:
    directories:
        - ./node_modules

# Get GitHub token (public_repo) from https://github.com/settings/tokens/new and set it as GH_TOKEN env parameter
# env:
#     global:
GIT_REPO="https://${GH_TOKEN}@github.com/michelek/e_kogumelugu.git"
GIT_USER="Mihkel Putrinš"
GIT_EMAIL="mihkel.putrinsh@gmail.com"
BUILD_DIR=./build
SOURCE_DIR=./source
OUT_DIR=./tmp_source
ENTU_URL=https://kogumelugu.entu.ee
E_DEF=interview
PARENT_EID=1150
TEMPLATE=${SOURCE_DIR}/item.jade
DATA_LIST=${OUT_DIR}/entities.yaml

# before_script:
mkdir ${OUT_DIR}
cp -r ${SOURCE_DIR}/* ${OUT_DIR}

mkdir ${BUILD_DIR}
cd ${BUILD_DIR}
git clone ${GIT_REPO} ./
git checkout gh-pages
git pull

cd ${TRAVIS_BUILD_DIR}

rm -rf ${BUILD_DIR}/assets
mkdir -p ${BUILD_DIR}/assets
cp -r ./assets/* ${BUILD_DIR}/assets

npm install entu-cms

# script:
./node_modules/entu-cms/helpers/entu2yaml.js
./node_modules/entu-cms/build.js ./entu-cms.yaml cleanup

# after_success:
    # - SOURCE_COMMIT=$(git rev-parse --short HEAD)
    #
    # - cd ${BUILD_DIR}
    # - git config user.name ${GIT_USER}
    # - git config user.email ${GIT_USER}
    # - git add -A .
    # - git commit -m "Rebuild gh-pages at commit ${SOURCE_COMMIT}"
    # - git push
