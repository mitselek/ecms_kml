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
# mkdir ${BUILD_DIR}
#
# cd ${BUILD_DIR}
# git clone ${GIT_REPO} ./
# git checkout gh-pages
# git pull
# cd ..

rm -rf ${BUILD_DIR}/assets
mkdir -p ${BUILD_DIR}/assets
cp -r ./assets/* ${BUILD_DIR}/assets

# npm install entu-cms

# script:
echo
echo --------- FETCH
echo --        videos
export E_DEF=
# export E_DEF=(story,interview)
export PARENT_EID=2577
# export PARENT_EID=1150
export ITEM_DIR=./_videos
export ITEM_YAML=video.yaml
export LIST_YAML=${OUT_DIR}/videos.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo --        partners
export E_DEF=
# export E_DEF=(institution,person)
export PARENT_EID=1178
export ITEM_DIR=
export ITEM_YAML=
export LIST_YAML=${OUT_DIR}/partners.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo --        financiers
export E_DEF=
# export E_DEF=institution
export PARENT_EID=1179
export ITEM_DIR=
export ITEM_YAML=
export LIST_YAML=${OUT_DIR}/financiers.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo --        thankstoteam
export E_DEF=
# export E_DEF=person
export PARENT_EID=1863
export ITEM_DIR=
export ITEM_YAML=
export LIST_YAML=${OUT_DIR}/thankstoteam.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo --        thankstosupporters
export E_DEF=
# export E_DEF=person
export PARENT_EID=1180
export ITEM_DIR=
export ITEM_YAML=
export LIST_YAML=${OUT_DIR}/thankstosupporters.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo --        coproducer
export E_DEF=
# export E_DEF=person
export PARENT_EID=1177
export ITEM_DIR=
export ITEM_YAML=
export LIST_YAML=${OUT_DIR}/coproducer.yaml
~/node_modules/entu-cms/helpers/entu2yaml.js

echo
echo --------- BUILD
~/node_modules/entu-cms/build.js ./entu-cms.yaml

# echo
# echo --------- COMMIT
#
# # after_success:
# SOURCE_COMMIT=$(git rev-parse --short HEAD)
#
# cd ${BUILD_DIR}
# git config user.name ${GIT_USER}
# git config user.email ${GIT_USER}
# git add -A .
# git commit -m "Rebuild gh-pages at commit ${SOURCE_COMMIT}"
# git push
# cd ..
