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
env GIT_REPO="https://${GH_TOKEN}@github.com/mitselek/ecms_kml.git"
env GIT_USER="Mihkel Putrinš"
env GIT_EMAIL="mihkel.putrinsh@gmail.com"

env BUILD_DIR=./build
env SOURCE_DIR=./source
env OUT_DIR=./tmp_source
env ENTU_URL=https://kogumelugu.entu.ee
env E_DEF=interview
env PARENT_EID=1150

env TEMPLATE=${SOURCE_DIR}/item.jade
env DATA_LIST=${OUT_DIR}/entities.yaml

# before_script:
mkdir ${OUT_DIR}
cp -r ${SOURCE_DIR}/* ${OUT_DIR}

rm -rf ${BUILD_DIR}
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
~/node_modules/entu-cms/helpers/entu2yaml.js
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
