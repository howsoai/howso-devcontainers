
<div align="left">
<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://cdn.howso.com/img/howso/1/svg/logo-gradient-light.svg" width="33%">
 <source media="(prefers-color-scheme: light)" srcset="https://cdn.howso.com/img/howso/1/svg/logo-gradient-dark.svg" width="33%">
 <img alt="Howso" src="https://cdn.howso.com/img/howso/1/png/logo-gradient-light-bg.png" width="33%">
</picture>
</div>

The Howso Engine&trade; is a natively and fully explainable ML engine, serving as an alternative to black box AI neural networks. Its core functionality gives users data exploration and machine learning capabilities through the creation and use of Trainees that help users store, explore, and analyze the relationships in their data, as well as make understandable, debuggable predictions. Howso leverages an instance-based learning approach with strong ties to the [k-nearest neighbors algorithm](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) and [information theory](https://en.wikipedia.org/wiki/Information_theory) to scale for real world applications.

At the core of Howso is the concept of a Trainee, a collection of data elements that comprise knowledge. In traditional ML, this is typically referred to as a model, but a Trainee is original training data coupled with metadata, parameters, details of feature attributes, with data lineage and provenance. Unlike traditional ML, Trainees are designed to be versatile, a single model that after training a dataset can do the following without the need to retrain:

- Perform **classification** on any target feature using any set of input features
- Perform **regression** on any target feature using any set of input features
- Perform **anomaly detection** based on any set of features
- Measure **feature importance** for predicting any target feature
- **Synthesize** data that maintains the same feature relationships of the original data while maintaining privacy

Furthermore, Trainees are auditable, debuggable, and editable.

- **Debuggable**: Every prediction of a Trainee can be drilled down to investigate which cases from the training data were used to make the prediction.
- **Auditable**: Trainees manage metadata about themselves including: when data is trained, when training data is edited, when data is removed, etc.
- **Editable**: Specific cases of training data can be removed, edited, and emphasized (through case weighting) without the need to retrain.

## Resources

- [Documentation](https://docs.howso.com)
- [Howso Engine Recipes (sample notebooks)](https://github.com/howsoai/howso-engine-recipes)
- [Howso Playground](https://playground.howso.com)

## General Overview

Howso Development Containers are an easy, ready to use option for running Howso Engine. The dev container images are built to include Howso Engine and all dependencies so you can just load it and run Jupyter notebooks or python from VS Code. Using the dev containers require Docker and VS Code, but avoids setting up and maintaining your own python environment with Howso Engine installed.

## Benefits of Using a Dev Container

- Lower installation requirements. General purpose development software like Docker and VS Code is needed, but Howso software is included in the dev container.
- Setup and maintenance of a python environment is not needed.
- Installing Howso Engine or dependencies isn't needed, they're all prepackaged and ready to use.
- No need to `pip install` any packages or to make sure compatible versions of python packages are installed.
- Switching between versions of the Howso Engine and/or python is as simple as restarting VS Code in a different container.
- Since nothing is installed, there's nothing to maintain or clean up when finished. You can always jump to a newer version in the future just by starting with a new dev container image.
- It's possible to extend the dev container to include additional packages by building a new container image with the Howso Development Container as a base.

## Tags

Howso Development Container [images](https://github.com/howsoai/howso-devcontainers/pkgs/container/howso) are released in conjunction with the Howso Engine. When a release occurs, an image is built for each version of python supported by Howso Engine.

### `<engine version>-python<python version>`

Examples:
- `1.2.3-python3.8`
- `5.6.7-python3.11`

This is the fully qualified tag that includes both the version of Howso Engine and python. This tag is immutable and will always reference the same image.

### `python<python version>` 

Examples:
- `python3.11`
- `python3.10`

Each time a release occurs, the images are tagged with a shortened tag including only the python version. This tag is mutable and will refer to the image with the most recent release of Howso Engine running on the specified version of python.

Because of the mutable nature of this tag, it's possible to create confusion about which version or dev container image is in use. If used on system where images may have been run previously using the tag, running `docker pull howso:python<python version>` is recommended prior to use to make sure it is current.

### `latest`

The `latest` tag is a mutable tag that refers to the most recent version of Howso Engine along with the highest version train for python. This is the tag used by default if none is provided when running.

Because of the mutable nature of this tag, it's possible to create confusion about which version or dev container image is in use. If used on system where images may have been run previously using the tag, running `docker pull howso:latest` is recommended prior to use to make sure it is current.

## Supported Platforms

Compatible with Python versions: 3.8, 3.9, 3.10, and 3.11

**Operating Systems**

| OS      | x86_64 | arm64 |
|---------|--------|-------|
| Windows | Yes    | No    |
| Linux   | Yes    | Yes   |
| MacOS   | Yes    | Yes   |

## Quick Start

More details are available in the next section, but here are the basic steps:
1. Make sure Docker is installed and running
1. Make sure VS Code is installed, including the [VS Code Dev Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
1. If necessary, add a `.devcontainer` directory to your workspace with subdirectories and `devcontainer.json` files for each dev container version you may want to run.
1. Run VS Code from your workspace directory (e.g. `vscode .`)
1. Use the blue "><" button in the lower left corner of VS Code to open the dev container menu.
1. Select "Reopen in Container" and pick which dev container version you'd like to to use for the current session
1. Once it's restarted, you should be able to run notebooks and python from that VS Code session using Howso Engine

## Using the Dev Container

Assuming that the prerequisites (i.e. Docker and VS Code) have been installed, using the dev container starts with adding a `.devcontainers` directory where you plan to run VS Code. This would typically be a directory that contains Jupyter notebooks or python code that you want to run using Howso Engine. In the case of the [Howso Engine Recipes](https://github.com/howsoai/howso-engine-recipes), this has already been done and can serve as an example.

Within the `.devcontainers` directory, create a subdirectory for each dev container image you'd like to make available when running VS Code. Note that the subdirectory name will be shown in VS Code when selecting the dev container to use, so make it something readable that reflects the image version.

Once created, each subdirectory needs a JSON file named `devcontainer.json` that specifies the dev container image to use. Here are some example contents:
```
{
    "image": "ghcr.io/howsoai/howso:9.1.5-python3.11",
    "customizations": {
        "vscode": {
          "extensions": ["ms-toolsai.jupyter"]
        }
    }
}
```

This example uses the tag `9.1.5-python3.11`, but should be adjusted for the image you're interested in running. By default, this image will load the Jupyter extension into the running dev container. The extensions you have installed locally may not be loaded automatically when restarting in the dev container. They can be installed in the dev container by adding to the list of `extensions` in the `devcontainer.json` file or by using the VS Code user interface. There are further customizations possible, please see Microsoft's [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers) for additional details.

Once the prerequisites are installed, Docker is running and the `.devcontainer` directory is set up, it's time to run VS Code. Start it by running `vscode .` in your workspace directory. 

From that VS Code window the blue "><" button in the lower left corner of VS Code to open the dev container menu. Then, select "Reopen in Container" and pick which dev container version you'd like to to use for the current session

Once VS Code has restarted, you should be able to run notebooks and python from that VS Code session using Howso Engine. The terminal window within VS Code can be used to inspect the python version (i.e. `python --version`) or to show the list of python packages available (i.e. `pip list`).

After you've completed using the VS Code dev container session, you can simply close the window.

## Prerequisites

The development container images aren't installed in the traditional sense, but there are required prerequisites. Make sure the following are installed before trying to use the Howso dev container:
- [Docker](https://docs.docker.com/get-docker/)
- [Visual Studio Code (VS Code)](https://code.visualstudio.com/)
  - [VS Code Dev Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

[Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers) has good information and instructions for getting prepared to use dev containers. It covers specific recommendations for Docker variants based on OS and architecture. Please review the getting started section to make sure your setup is ready. 

Although dev containers support running locally or with Docker installed on a remote host (e.g. VM), running locally is typically simpler when getting started. It's recommended to get started with Docker running locally, but the Howso Development Container should work remotely too.

## License

[License](LICENSE.txt)

## Contributing

[Contributing](CONTRIBUTING.md)