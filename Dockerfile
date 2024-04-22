ARG PY_VERSION=3.12
# FROM python:${PY_VERSION}
FROM mcr.microsoft.com/devcontainers/python:${PY_VERSION}-bullseye

# A valid engine version must be provided as a build argument
ARG HOWSO_ENGINE_VERSION=undefined

# Install howso
RUN pip install howso-engine==${HOWSO_ENGINE_VERSION}

# Install additional development container requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Create non-root user
RUN groupadd -r howso && useradd -m -g howso howso
RUN chown -R howso:howso /home/howso
WORKDIR /home/howso
USER howso
