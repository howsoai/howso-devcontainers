ARG PY_VERSION=3.12
FROM mcr.microsoft.com/devcontainers/python:${PY_VERSION}-bullseye

# ARG HOWSO_ENGINE_VERSION=9.1.5
# RUN pip install howso-engine==${HOWSO_ENGINE_VERSION}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
