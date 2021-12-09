# Dockerfile for Jupyter

# Base image
#FROM scratch
FROM ubuntu:18.04

# Working directory
WORKDIR /app

# Copy current directory to /app
COPY . /app

# Available ports outside this container
EXPOSE 8000

# Define environment variables
ENV PATH="/app/miniconda3/bin:${PATH}"
ENV J_INSTALLATION_FOLDER="/app/J807"
ENV J_BIN_FOLDER="/app/J807/bin"

## add required elements from binder https://github.com/binder-examples/minimal-dockerfile/blob/master/Dockerfile
# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# don't run the entry point for binder
# Run it
# ENTRYPOINT ["/app/run.sh"]

