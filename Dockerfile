FROM ubuntu:22.04

# Author label
LABEL maintainer="Yucheng Zhang <Yucheng.Zhang@tufts.edu>"

# Description label
LABEL description="This container contains Miniforge installed on Ubuntu 22.04."

# Set environment variables
ENV PATH=/opt/miniforge/bin:$PATH

# Install dependencies and Miniforge
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends wget git  && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/conda-forge/miniforge/releases/download/24.11.0-0/Miniforge3-24.11.0-0-Linux-x86_64.sh && \
    bash Miniforge3-24.11.0-0-Linux-x86_64.sh -b -p /opt/miniforge && \
    rm -f Miniforge3-24.11.0-0-Linux-x86_64.sh && \


# Update and clean conda
RUN conda update -n base conda -y && \
    conda update --all -y && \
    conda clean --all --yes && \
    rm -rf /root/.cache/pip

# Set default shell to bash
SHELL ["/bin/bash", "-c"]
