#!/usr/bin/env bash
cd `dirname $0` && DIR=$(pwd) && cd -
WORKDIR="$DIR/application-git"
. ${DIR}/config.sh

if [[ ! -d ${DIR}/.git ]]; then
    git --git-dir=${DIR}/.git init
    git --git-dir=${DIR}/.git add .
    git --git-dir=${DIR}/.git commit -m "initial"
fi

if [[ ! -d ${WORKDIR} ]] || [[ ! -d ${WORKDIR}/.git ]]; then
    mkdir -p ${WORKDIR}/.git
    git --git-dir=${WORKDIR}/.git init
    git --git-dir=${WORKDIR}/.git remote add origin ${APP_GIT_URI}
fi

git --git-dir=${WORKDIR}/.git pull

read -d '' dockerfile << EOF
FROM djocker/orobase
USER www-data

# HTTPS or SSH
# If you want to use ssh don't forget to provide ssh key via build arg directive
ENV GIT_URI=%GIT_URI%

# branch name or tag 
# master - for master branch
# tags/1.9.1 - for 1.9.1 tag 
ENV GIT_REF=%GIT_REF%

RUN install-application.sh

USER root
CMD ["run.sh"]
EOF

dockerfile=${dockerfile//%GIT_URI%/${APP_GIT_URI}}

while read tag;
do
    _dockerfile=${dockerfile}
    _dockerfile=${_dockerfile//%GIT_REF%/tags/${tag}}
    echo "PROCESS TAG: $tag"
    if [[ ! -z ${START_FROM_TAG} ]] && [[ $(php -r "echo version_compare('${tag}', '${START_FROM_TAG}');") -lt 0 ]]; then
        echo "Skipping..."
    else
        echo "$_dockerfile" > "Dockerfile"
        git --git-dir=${DIR}/.git add -f Dockerfile
        git --git-dir=${DIR}/.git commit -m "bump $tag"
        git --git-dir=${DIR}/.git tag -a "$tag" -m "bump $tag"
    fi
done < <(diff -a <(git --git-dir=${DIR}/.git show-ref --tags | awk '{print $2}') <(git --git-dir=${WORKDIR}/.git ls-remote --tags | grep -v '\^{}' | awk '{print $2}') | grep '>' | awk -F '/' '{print $3}')

# For auto push uncomment line below
git --git-dir=${DIR}/.git push --all origin
git --git-dir=${DIR}/.git push --tags origin
