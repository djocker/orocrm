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

read -d '' dockerfile << EOF
FROM djocker/orobase
USER www-data

# Build Args
ENV MEMORY_LIMIT_CLI=2048
ENV MEMORY_LIMIT_FPM=2048
ENV UPLOAD_LIMIT=256
ENV GIT_URI=%GIT_URI%
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
