# Gatekeeper Policy Manager Task Automation

This README provides an overview of the task automation process for managing the Gatekeeper Policy Manager Helm chart, including installation, configuration, and demonstration tasks.

**Gatekeeper Policy Manager** is a user-friendly interface designed to simplify the management of policies within the Gatekeeper ecosystem. It provides an intuitive way to create, modify, and visualize policies enforced by Gatekeeper, making it easier for administrators to ensure compliance and governance in Kubernetes clusters. By offering a streamlined and accessible approach to policy management, **Gatekeeper Policy Manager** enhances the efficiency and effectiveness of maintaining secure and compliant cloud-native environments.

## Variables

- **gkpm_controller_name**: The name of the Gatekeeper Policy Manager controller.
- **gkpm_controller_namespace**: The namespace where the Gatekeeper Policy Manager will be deployed (`gatekeeper-system`).
- **gkpm_controller_repo**: The Helm chart repository for Gatekeeper Policy Manager.
- **gkpm_controller_chart_version**: The version of the Gatekeeper Policy Manager Helm chart.
- **gkpm_local_registry**: The local Docker registry.

## Task Definitions

### **install-dev**

Runs the development installation process, including setting the ArgoCD context, performing a dry run, and applying the configuration.

### **install**

Installs the Gatekeeper Policy Manager by performing a dry run and applying the configuration.

### **create-wrapper-chart**

Creates a wrapper chart in the specified directory with the necessary variables for the Gatekeeper Policy Manager.

### **create-values**

Generates a `values.yaml` file in the specified directory for the Gatekeeper Policy Manager controller. If an existing `values.yaml` file is found, it is backed up before creating the new file.

### **dryrun**

Performs a dry run of the Helm chart installation, including adding the Helm repository, building dependencies, and templating the chart.

### **apply**

Applies the Helm chart installation, including building dependencies and installing the chart.

### **full-run**

Executes the complete process of creating the wrapper chart, generating the `values.yaml` file, performing a dry run, and applying the installation.

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
    - Generate new `values.yaml` file with optional configuration for secret key and ingress settings.

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

These tasks automate the process of managing the Gatekeeper Policy Manager Helm chart, ensuring consistent and repeatable deployments.
