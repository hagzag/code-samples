# Goldilocks Task Automation

This README provides an overview of the task automation process for managing the Goldilocks Helm chart, including installation and configuration steps.

## Variables

- **gl_controller_name**: The name of the Goldilocks controller.
- **gl_controller_namespace**: The namespace where Goldilocks will be deployed.
- **gl_controller_repo**: The Helm chart repository for Goldilocks.
- **gl_controller_chart_version**: The version of the Goldilocks Helm chart.
- **gl_local_registry**: The local Docker registry.

## Task Definitions

### `install-dev`

Runs the development installation process, including setting the ArgoCD context, performing a dry run, and applying the configuration.

### `install`

Installs Goldilocks by performing a dry run, applying the configuration, and labeling the namespace for Goldilocks.

### `create-wrapper-chart`

Creates a wrapper chart in the specified directory with the necessary variables for Goldilocks.

### `create-values`

Generates a `values.yaml` file in the specified directory for the Goldilocks controller. If an existing `values.yaml` file is found, it is backed up before creating the new file.

### `dryrun`

Performs a dry run of the Helm chart installation, including adding the Helm repository, building dependencies, and templating the chart.

### `apply`

Applies the Helm chart installation, including building dependencies and installing the chart.

### `full-run`

Executes the complete process of creating the wrapper chart, generating the `values.yaml` file, performing a dry run, and applying the installation.

## Execution Flow

1. **Development Installation (`install-dev`)**:
    - Set kubernetes context.
    - Perform a dry run.
    - Apply the configuration.

2. **Production Installation (`install`)**:
    - Perform a dry run.
    - Apply the configuration.
    - Label the namespace.

3. **Wrapper Chart Creation (`create-wrapper-chart`)**:
    - Create the wrapper chart in the specified directory.

4. **Values File Creation (`create-values`)**:
    - Backup existing `values.yaml` file, if any.
    - Generate new `values.yaml` file.

5. **Dry Run (`dryrun`)**:
    - Add Helm repository.
    - Build dependencies.
    - Template the chart.
    - Perform a dry run of the templated chart.

6. **Apply Configuration (`apply`)**:
    - Build dependencies.
    - Install the chart.

7. **Full Run (`full-run`)**:
    - Execute wrapper chart creation.
    - Generate `values.yaml` file.
    - Perform dry run.
    - Apply the installation.

These tasks automate the process of managing the Goldilocks Helm chart, ensuring consistent and repeatable deployments.