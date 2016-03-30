FROM djocker/orobase
USER www-data

# Build Args
ENV MEMORY_LIMIT_CLI=2048
ENV MEMORY_LIMIT_FPM=2048
ENV UPLOAD_LIMIT=256
ENV GIT_URI=https://github.com/orocrm/crm-application.git
ENV GIT_REF=tags/1.9.1

RUN install-application.sh

USER root
CMD ["run.sh"]
