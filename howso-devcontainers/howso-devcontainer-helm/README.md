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



## References

[1] Microsoft, “Prepare your Azure container technical assets for a Kubernetes application - Marketplace publisher,” learn.microsoft.com, Feb. 22, 2024. Available: https://learn.microsoft.com/en-us/partner-center/marketplace/azure-container-technical-assets-kubernetes. [Accessed: Apr. 21, 2024]

[2] Microsoft, “Plan an Azure Container offer - Marketplace publisher,” Microsoft.com, Jan. 30, 2024. Available: https://learn.microsoft.com/en-us/partner-center/marketplace/marketplace-containers. [Accessed: Apr. 21, 2024]

[3] Microsoft, “Mastering Container offers for Kubernetes apps - Mastering the Marketplace,” microsoft.github.io. Available: https://microsoft.github.io/Mastering-the-Marketplace/container/#container-offer-for-kubernetes-apps-overview. [Accessed: Apr. 21, 2024]