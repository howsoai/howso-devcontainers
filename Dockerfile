ARG PY_VERSION=3.12
FROM mcr.microsoft.com/devcontainers/python:${PY_VERSION}-bullseye

# A valid engine version must be provided as a build argument
ARG HOWSO_ENGINE_VERSION=undefined
RUN pip install howso-engine==${HOWSO_ENGINE_VERSION}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
