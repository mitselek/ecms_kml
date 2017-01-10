#!/bin/bash

# node_js:
#     - '6'
#
# cache:
#     directories:
#         - ./node_modules

# Get GitHub token (public_repo) from https://github.com/settings/tokens/new and set it as GH_TOKEN env parameter
# env:
#     global:
. gh_token.sh
export GIT_REPO="https://${GH_TOKEN}@github.com/mitselek/ecms_kml.git"
export GIT_USER="Mihkel Putrinš"
export GIT_EMAIL="mihkel.putrinsh@gmail.com"

export BUILD_DIR=./build
export SOURCE_DIR=./source
export OUT_DIR=./tmp_source
export ENTU_URL=https://kogumelugu.entu.ee

# before_script:
mkdir ${OUT_DIR}
cp -r ${SOURCE_DIR}/* ${OUT_DIR}

# rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
echo cd ${BUILD_DIR}
cd ${BUILD_DIR}
pwd

echo git clone ${GIT_REPO} ./
git clone ${GIT_REPO} ./
echo git checkout gh-pages
git checkout gh-pages
echo git pull
git pull

echo cd ..
cd ..
pwd

rm -rf ${BUILD_DIR}/assets
mkdir -p ${BUILD_DIR}/assets
cp -r ./assets/* ${BUILD_DIR}/assets

# npm install entu-cms

# script:
echo
echo --------- FETCH
export E_DEF=story
export PARENT_EID=1150
export TEMPLATE=${SOURCE_DIR}/item.jade
export DATA_LIST=${OUT_DIR}/stories.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

export E_DEF=interview
export PARENT_EID=1150
export TEMPLATE=${SOURCE_DIR}/item.jade
export DATA_LIST=${OUT_DIR}/interviews.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo
echo --------- BUILD
~/node_modules/entu-cms/build.js ./entu-cms.yaml cleanup

# after_success:
# SOURCE_COMMIT=$(git rev-parse --short HEAD)
#
# cd ${BUILD_DIR}
# git config user.name ${GIT_USER}
# git config user.email ${GIT_USER}
# git add -A .
# git commit -m "Rebuild gh-pages at commit ${SOURCE_COMMIT}"
# git push
