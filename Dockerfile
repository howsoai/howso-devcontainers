ARG PY_VERSION=3.12
FROM mcr.microsoft.com/devcontainers/python:${PY_VERSION}-bullseye

RUN pip install pmlb "ipykernel>=6.0.0,<7" howso-engine
