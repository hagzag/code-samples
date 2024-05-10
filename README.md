# Code-samples | The code behind the posts ...

This repo was setup to centralize code examples I mention in different blog posts, 
this is part of my attempt to manage all these snippets / samples in once place.

- The 1st contribution to this repo was for the post involving `external-dns` - some finishes in the making ;)
- The 2nd was the [k3d-intro](./posts/k3d-intro/README.md) is still WIP, it's code was quite useful to me for quite a while ...
  
I hope to to continue maintaining this and making this a table of features.

## Using these tasks / `Taskfile.yml` Documentation:

Here is a Markdown-formatted documentation for the provided `Taskfile.yml`:

### Overview

This `Taskfile.yml` configures task automation for various components related to Kubernetes, DNS configurations, and deployment of several applications and services. It integrates environment settings and modular task files from different repository paths.

### Environment Configuration

- **Dotenv**: Loads environment variables from `.env` see `.env-example` which if frequently updated

### Included Task Files

- **General Utilities**: 
  - `helm`: Helm chart templates
  - `templates`: General various templates 
- **Testing**:
  - `test`: Specific tests (1 so far ...)
- **Deployment Tasks**:
  - `k3d`, `external-dns`, `coredns`, `argocd`, `nginx`: Tasks related to deploying these services
- **Tools and Configuration Management**:
  - `tools`, `config-managment`, `vault`, `awx`: Tools and configurations for management
- **Applications and Packages**:
  - `cicd-toolz`, `chartmeusem`: CI/CD tools and chart museum setup
- **Observability**:
  - `monitoring-n-logging`: Monitoring and logging services

### Key Tasks

- **k3d-intro-insecure and k3d-intro**: Commands to start k3d clusters with various configurations.
- **external-dns and coredns**: Tasks to deploy and test DNS configurations.
- **argocd and nginx**: Deployment of ArgoCD and Nginx.
- **config-managment**: Configuration management deployment.
- **so-far**: Aggregates core tasks for setup and deployment.
- **run-tests**: Executes defined tests.
- **help**: Displays help and task listing.

### Usage

Run tasks using the command `task <task-name>`, where `<task-name>` refers to the task identifier to execute specific operations outlined in the `Taskfile.yml`.

## All commands

```sh
# task --list-all
task: Available tasks for this project:
* argocd:                                                 Deploy argocd project
* config-managment:                                       Run all config-managment tasks
* coredns:                                                Run the codedns project
* external-dns:                                           Run the external-dns project
* help:                                                   Show help
* k3d-intro:                                              Start the k3d cluster
* k3d-intro-insecure:                                     Start the k3d cluster
* nginx:                                                  Deploy nginx project
* run-tests:                                              Run tests
* so-far:                                                 Run core tasks
* argocd:bridge:                                          
* argocd:install:                                         Installs ArgoCD resources manually on the local cluster
* argocd:password:                                        
* argocd:repo:                                            
* argocd:rm:                                              
* argocd:secret:                                          
* awx:cli-login:                                          
* awx:create-argo-apps:                                   
* awx:get-awx-admin-password:                             
* awx:install:                                            
* awx:run-ansible-k8s-exmaple:                            Run the ansible k8s example
* awx:run-awx-playbook:                                   
* awx:secret:                                             
* awx:uninstall:                                          
* chartmeusem:install-argo-app:                           Installs nginx resources manually on the local cluster
* chartmeusem:rm:                                         
* chartmeusem:tweak-chartmeusem-test:                     Tear down the chartmeusem chart
* cicd-toolz:add-submodule:                               
* cicd-toolz:cleanup-pod-manifest:                        Run the pod manifest
* cicd-toolz:cleanup-submodule:                           Remove the submodule
* cicd-toolz:docker-build:                                Build the docker image
* cicd-toolz:run-pod-manifest:                            Run the pod manifest
* config-managment:dockercondig-secret:                   Create a dockerconfig secret
* config-managment:dockercondig-secret-clenup:            
* config-managment:install:                               Installs reloader + scheduler resources manually on the local cluster
* config-managment:rm:                                    
* coredns:dns-test:                                       
* external-dns:pkg-part-3:                                Build the project
* helm:create-wrapper-chart:                              
* k3d:certs:                                              Creates and uploads local certificates to the cluster as tls secrets
* k3d:cluster-create:                                     Starts a local k3d cluster.
* k3d:cluster-template:                                   Create a k3d cluster template
* k3d:delete-cluster:                                     
* k3d:dns:                                                Creates the DNS entry required for the local domain to work.
* k3d:hosts-file:                                         Adds a line to the hosts file if it doesn't already exist.
* k3d:ns:system:                                          
* monitoring-n-logging:all:                               
* monitoring-n-logging:apply-kube-prometheus-stack:       Applies the kube-prometheus stack.
* monitoring-n-logging:apply-loki-stack:                  Applies the loki stack.
* monitoring-n-logging:create-argo-apps:                  
* monitoring-n-logging:secret:                            
* nginx:install:                                          Installs nginx resources manually on the local cluster
* nginx:rm:                                               
* templates:argocd:                                       
* templates:certificate:                                  
* templates:chartmeusem:                                  
* templates:example:                                      
* templates:gen:                                          
* test:helm-wrapper:                                      
* test:helm:create-wrapper-chart:                         
* tools:clear:                                            
* tools:highlight_bg:                                     
* tools:highlight_normal:                                 
* tools:hostctl:                                          
* tools:install:                                          
* tools:jq:                                               
* tools:k3d:                                              
* tools:kubectl:                                          
* tools:kustomize:                                        
* tools:mkcert:                                           
* tools:reset:                                            
* tools:vault:                                            
* vault:install:                                          
* vault:install-eso:                                      Installs vault + eso resources manually on the local cluster
* vault:install-vault:                                    Installs vault + eso resources manually on the local cluster
* vault:install-vault-eso-example:                        Installs vault + eso resources manually on the local cluster
* vault:test-result:                                      
* vault:uninstall:                                        
* vault:uninstall-eso:                                    Uninstalls eso resources from the local cluster
* vault:uninstall-vault:                                  Uninstalls vault + eso resources from the local cluster
* vault:uninstall-vault-eso-example:                      Uninstalls vault + eso resources from the local cluster
```