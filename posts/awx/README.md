# install and test awx with ansible plaubook

## Required env vars

- `NAMESPACE` - the namespace which runs awx
- `CLUSTER_NAME` - the name of the cluster
- `AWX_ADMIN_PASSWORD` - awx admin password
- `AWX_DATABASE_PASSWORD` - awx database password
- `TOWER_HOST` - `https://awx.k8s.localhost`
- `TOWER_USERNAME` - admin
- `TOWER_PASSWORD` - $AWX_ADMIN_PASSWORD

## Install awx on local k3d cluster

- `task awx:install`

## cli login

- `task awx:cli-login`

## Uninstall

- `task awx:uninstall`