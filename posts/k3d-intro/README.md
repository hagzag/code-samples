# k3d Intro [ To be continued ... ]

This guide will help you get started with setting up a local Kubernetes cluster using k3d, with a twist: the cluster will be named "playground".

## Prerequisites

Before getting started, ensure you have the following prerequisites:

- **k3d**: Make sure you have k3d installed on your system. If not, you can install it by running:

  ```bash
  task install-tools
  ```

- **Linux / macOS**: This guide assumes you are using either Linux or macOS. Instructions may vary slightly for other operating systems.

## Getting Started

To create a local Kubernetes cluster named "playground" using k3d, follow these steps:

1. **Start Cluster**: Run the following command to start the cluster:

   ```bash
   task create-cluster 
   ```

   This command will create a k3d cluster named "playground", currently configured with 1 server and 2 agents.

2. **Confirm Cluster Creation**: After the command finishes executing, you can confirm that the cluster has been created by running:

   ```bash
   k3d cluster list
   ```

   You should see your "playground" cluster listed.

3. **Explore**: Your cluster is now ready for use. You can start deploying applications and testing Kubernetes features in your local environment.

## Deleting the Cluster

Once you're done using the cluster, you can delete it using the following command:

```bash
task delete-cluster
```

This will delete the "playground" cluster.

---

Please note that this guide assumes basic familiarity with Kubernetes concepts and command-line interfaces. For more detailed information on k3d and Kubernetes, refer to the official documentation.
```

Feel free to adjust any parts of the guide to better suit your needs!