FROM djocker/orobase
USER www-data

# Build Args
ENV MEMORY_LIMIT_CLI=2048
ENV MEMORY_LIMIT_FPM=2048
ENV UPLOAD_LIMIT=256

# ARG SSH_PRIVATE_KEY
# ARG GITHUB_TOKEN

# HTTPS or SSH
# If you want to use ssh don't forget to provide ssh key via build arg directive
ENV GIT_URI=https://github.com/orocrm/crm-application.git

# branch name or tag 
# master - for master branch
# tags/1.9.1 - for 1.9.1 tag 
ENV GIT_REF=tags/1.9.1

RUN install-application.sh

USER root
CMD ["run.sh"]
