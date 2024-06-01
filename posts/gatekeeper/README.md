# Gatekeeper Task Automation

This README provides an overview of the task automation process for managing the Gatekeeper Helm chart, including installation, configuration, and demonstration tasks.
**Gatekeeper**, part of the Open Policy Agent (OPA) ecosystem, is a policy enforcement tool for Kubernetes. It allows administrators to define, manage, and enforce policies governing Kubernetes resources using a declarative syntax. By leveraging OPA's powerful policy language, Rego, Gatekeeper ensures that Kubernetes clusters comply with organizational policies, enhancing security and operational consistency. This makes **Gatekeeper** an essential component for maintaining governance and compliance in cloud-native environments.

## Variables

- **gk_controller_name**: The name of the Gatekeeper controller.
- **gk_controller_namespace**: The namespace where Gatekeeper will be deployed (`gatekeeper-system`).
- **gk_controller_repo**: The Helm chart repository for Gatekeeper.
- **gk_controller_chart_version**: The version of the Gatekeeper Helm chart.
- **gk_local_registry**: The local Docker registry.

## Task Definitions

### **install-dev**

Runs the development installation process, including setting the ArgoCD context, performing a dry run, and applying the configuration.

### **install**

Installs Gatekeeper by performing a dry run and applying the configuration.

### **create-wrapper-chart**

Creates a wrapper chart in the specified directory with the necessary variables for Gatekeeper.

### **create-values**

Generates a `values.yaml` file in the specified directory for the Gatekeeper controller. If an existing `values.yaml` file is found, it is backed up before creating the new file.

### **dryrun**


Performs a dry run of the Helm chart installation, including adding the Helm repository, building dependencies, and templating the chart.

### **apply**


Applies the Helm chart installation, including building dependencies and installing the chart.

### **full-run**


Executes the complete process of creating the wrapper chart, generating the `values.yaml` file, performing a dry run, and applying the installation.

### Demo Tasks

#### `delete-constraint-template`

Deletes the constraint template `k8srequiredlabels` in the specified demo directory.

#### `create-constraint-template`

Creates a constraint template `k8srequiredlabels` using Rego policy to enforce required labels on Kubernetes resources.

#### `delete-constraint`

Deletes the constraint `ns-must-have-gk` that enforces the required labels on namespaces.

#### `create-constraint`

Creates a constraint `ns-must-have-gk` to enforce that namespaces must have a specific label, excluding certain system namespaces.

#### `test-constraint-expect-failure`

Tests the constraint by attempting to create a namespace without the required label, expecting the operation to fail due to the constraint.

#### `test-constraint-expect-success`

Tests the constraint by creating a namespace with the required label, expecting the operation to succeed.

## Execution Flow

1. **Development Installation (`install-dev`)**:
    - Set ArgoCD context.
    - Perform a dry run.
    - Apply the configuration.

2. **Production Installation (`install`)**:
    - Perform a dry run.
    - Apply the configuration.

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

### Demonstration Tasks

1. **Delete Constraint Template (`delete-constraint-template`)**:
    - Remove the constraint template `k8srequiredlabels`.

2. **Create Constraint Template (`create-constraint-template`)**:
    - Define and apply a constraint template enforcing required labels.

3. **Delete Constraint (`delete-constraint`)**:
    - Remove the specific constraint `ns-must-have-gk`.

4. **Create Constraint (`create-constraint`)**:
    - Define and apply a constraint to enforce specific labels on namespaces.

5. **Test Constraint - Expect Failure (`test-constraint-expect-failure`)**:
    - Attempt to create a namespace without the required labels, expecting failure.

6. **Test Constraint - Expect Success (`test-constraint-expect-success`)**:
    - Create a namespace with the required labels, expecting success.

These tasks automate the process of managing the Gatekeeper Helm chart and demonstrate its enforcement capabilities, ensuring consistent and repeatable deployments and policy enforcement.