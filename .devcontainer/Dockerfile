FROM mcr.microsoft.com/devcontainers/python:3.13-trixie

ARG USERNAME=vscode

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y  \
    && apt-get -y install --no-install-recommends build-essential iputils-ping nodejs npm \
    && npm install -g @anthropic-ai/claude-code copilot-api \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/zsh
