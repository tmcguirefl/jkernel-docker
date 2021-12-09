FROM ubuntu:latest

# System packages
RUN apt-get update && apt-get install -yq curl wget jq vim

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda install -c conda-forge jupyterlab

# Define environment variables
ENV PATH="/app/miniconda3/bin:${PATH}"

# eventually move this up
RUN apt-get install -yq git sudo

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

ENV J_INSTALLATION_FOLDER="/home/$USER/j902/"
ENV J_BIN_FOLDER="/home/$USER/J902/bin"

RUN wget http://www.jsoftware.com/download/j902/install/j902_linux64.tar.gz && \
    tar -zxvf j902_linux64.tar.gz

RUN git clone https://github.com/martin-saurer/jkernel.git
WORKDIR ${HOME}/jkernel
USER root
RUN python setup.py install
WORKDIR ${HOME}
USER ${USER}

# Available ports outside this container
# EXPOSE 8000

# docker run -p 127.0.0.1:8000:8000 martinsaurer/jlang:jkernel
# ENTRYPOINT jupyter notebook --ip=0.0.0.0 --port=8000 --no-browser --allow-root
