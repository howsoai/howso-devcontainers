# Howso Devcontainer - Helm

This is a helm chart for the devcontainer. It was primarily created for generating an Azure Container Offering in the
Azure Marketplace but may be desired for otehr purposes.


## Generating a CNAB Bundle for Azure

Steps below are derived from reference [1].

### Update Image/Tag Information

The first step is to update the `howso-devcontainer-helm/values.yaml` file to setup tags or other information. This will
have the syntax:

```yaml
global:
  azure:
    images:
      devcontainer:
        tag: "18.1.2-python3.9"
        image: "howso"
        registry: "ghcr.io/howsoai"
      busybox:
        tag: "latest"
        image: "busybox"
        registry: "docker.io"
```

### Test Helm Configurtaion

Run a dry run install on the helm chart.

```bash
helm install howso-devcontainer-helm/ --generate-name --dry-run --debug
```

### Update Manifest version

The CNAB bundles are versioned separately. You'll want to increment/update the version in `manifest.yaml` accordingly:

```yaml

applicationName: com.howso.devcontainer
publisher: "HowSo"
description: "A test CNAB for the HowSo devcontainer running jupyter-lab."
version: 1.0.2 #Must be in the format of #.#.#
helmChart: "./howso-devcontainer-helm"
clusterArmTemplate: "./mainTemplate.json"
uiDefinition: "./createUIDefinition.json"
registryServer: "howso.azurecr.io"
extensionRegistrationParameters:
  defaultScope: "cluster" # cluster or namespace 
  namespace: "howso" # Specify the namespace the extension will install into. This property is required when defaultScope field value is chosen as 'cluster'
```

### Verify and Publish CNAB with Container-Package-App (CPA)

#### Launch CPA and Login

First launch the CPA tool:

```bash
docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $PWD:/data --entrypoint "/bin/bash" \
    mcr.microsoft.com/container-package-app:latest
```

Run the following to specify the registry and login; replace `howso` with any alternative registry desired:

```bash
export REGISTRY_NAME=howso
az login 
az acr login -n $REGISTRY_NAME
```

#### Verify CPA

Next, login to the target registry. The credentials will be stored in the **Access Keys** menu in the container
registry configuration view. A single username and 2 passwords are generated for every azure registry. For the
**howso** registry the admin user is **howso** for example. Use these credentials to login to the registry with docker.

```bash
root [ / ]# docker login howso.azurecr.io
Username: howso
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root [ / ]#
```

To verify the bundle, we can then run `cd /data; cpa verify`. Expected output below:

```bash
root [ / ]# cd /data
root [ /data ]# cpa verify
CPA Version:  1.3.12
By using the Azure Kubernetes CNAB Packaging Application, you agree to the License contained in the application. You can view the License at ~/LICENSE. 
We collect telemetry data, if you would like to opt out of data collection please use the --telemetryOptOut flag.
Correlation Id: b5a2eabc-0f2f-496c-b770-9cabd51eb1cf
Manifest file validated, 0 total failure(s)

Manifest verification successful.
Helm chart validated, 0 total failure(s)

Marketplace package validated, 0 total failures(s)

Helm chart and ARM template verification successful.
operation VerifySuccessful
root [ /data ]#
```

#### Build/Publish

Finally, run `cpa buildbundle` to build and publish the bundle to the repository. Abreviated output example below:

```bash
root [ /data ]# cpa buildbundle 
CPA Version:  1.3.12
# ...
# Lots of build actions happen 
# ...
Rewriting CNAB bundle.json...
Starting to copy image howso.azurecr.io/com.howso.devcontainer@sha256:2a5ebebd6b7c37e40c12d78f5750ccb47a3d372f73e8be2b7b2cdc1c9d90bdc0...
Completed image howso.azurecr.io/com.howso.devcontainer@sha256:2a5ebebd6b7c37e40c12d78f5750ccb47a3d372f73e8be2b7b2cdc1c9d90bdc0 copy
Starting to copy image docker.io/busybox@sha256:c3839dd800b9eb7603340509769c43e146a74c63dca3045a8e7dc8ee07e53966...
Completed image docker.io/busybox@sha256:c3839dd800b9eb7603340509769c43e146a74c63dca3045a8e7dc8ee07e53966 copy
Starting to copy image howso.azurecr.io/howso-devcontainer@sha256:8978d79f468090505bb8208631b647eb3cd1187ac342fbbd25c8ba2bd61be775...
Completed image howso.azurecr.io/howso-devcontainer@sha256:8978d79f468090505bb8208631b647eb3cd1187ac342fbbd25c8ba2bd61be775 copy
Bundle published successfully
operation BuildBundleSuccessful
root [ /data ]#
```

## References

[1] Microsoft, “Prepare your Azure container technical assets for a Kubernetes application - Marketplace publisher,” learn.microsoft.com, Feb. 22, 2024. Available: https://learn.microsoft.com/en-us/partner-center/marketplace/azure-container-technical-assets-kubernetes. [Accessed: Apr. 21, 2024]

[2] Microsoft, “Plan an Azure Container offer - Marketplace publisher,” Microsoft.com, Jan. 30, 2024. Available: https://learn.microsoft.com/en-us/partner-center/marketplace/marketplace-containers. [Accessed: Apr. 21, 2024]

[3] Microsoft, “Mastering Container offers for Kubernetes apps - Mastering the Marketplace,” microsoft.github.io. Available: https://microsoft.github.io/Mastering-the-Marketplace/container/#container-offer-for-kubernetes-apps-overview. [Accessed: Apr. 21, 2024]