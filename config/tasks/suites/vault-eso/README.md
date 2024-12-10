# Working with hashicorp-vault and external secrets operator

## Goals

- Get into the habbit of working with a secrets manager for local development
- Learn the basics of `external secrets operator` and it's integration with `vault`

## Perquisites

- k3d
- helm
- basic vault understanding

### Worth mentioning

This setup will initialize vault with a simple password - the password is `root` and you can use it both in the UI & vault api

### Installation

1. The official vault helm-chart for vault
   
   ```sh
   git clone code-samples
   cd config/apps/vault/vault
   helm dependency build .
   helm upgrade vault --install .
   ```

2. The official helm-chart for external-secrets

   ```sh
   cd config/apps/vault/vault-eso
   helm dependency build .
   helm upgrade external-secrets --install .
   ```

3. A custom helm-chart for the configuration named `vault-eso-example`

   ```sh
   cd config/apps/vault/vault-eso-example
   helm dependency build .
   helm upgrade vault-eso-example --install .
   ```

### Using the provided taskfile

    ```sh
    git clone code-samples
    task vault:install
    ```

### Testing the external secret is functioning as expected

    ```sh
    kubectl get -n default secret test -o json | jq '.data | map_values(@base64d)'
    ```

## What's the secret ?

1. Vault is installed in the `vault` namespace hence it's url is: `http://vault.vault:8200`
2. The token is `root` which is something you would probably do more securely in a public environment.
3. Cluster secret store is configured to retrieve secrets from vault via `clusterSecretStore`:

    ```yaml
    apiVersion: external-secrets.io/v1beta1
    kind: ClusterSecretStore
    metadata:
    name: vault-backend
    spec:
    provider:
        vault:
        auth:
            tokenSecretRef:
            key: token
            name: vault-token
            namespace: default
        path: secret
        server: http://vault.vault:8200
        version: v2
    ```

4. An external secret object is used to retrieve a secret via `clusterSecretStore`

    ```yaml
    apiVersion: external-secrets.io/v1beta1
    kind: ExternalSecret
    metadata:
    name: test
    namespace: default
    spec:
    data:
    - remoteRef:
        conversionStrategy: Default
        decodingStrategy: None
        key: secret/foo
        metadataPolicy: None
        property: hello
        secretKey: foobar
    refreshInterval: 15s
    secretStoreRef:
        kind: ClusterSecretStore
        name: vault-backend
    target:
        creationPolicy: Owner
        deletionPolicy: Retain
        name: test
    ```

## Cleanup

    ```sh
    task vault:uninstall
    ```
