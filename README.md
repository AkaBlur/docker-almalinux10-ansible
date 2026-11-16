# CentOS Stream 10 - Ansible Molecule testing image

[![Docker CI](https://github.com/AkaBlur/docker-almalinux10-ansible/actions/workflows/docker-publish.yaml/badge.svg?branch=master)](https://github.com/AkaBlur/docker-almalinux10-ansible/actions/workflows/docker-publish.yaml)

This image contains a fully setup AlmaLinux 10 image running `systemd` as
startup environment. Its intention is to be used as Ansible Molecule test runner
image using a containerization solution.

Works with:

- **podman** (preferred)
- Docker

## Usage

### Image

```bash
# podman
podman pull quay.io/rubixx_cube/almalinux-ansible:10
# Docker
docker pull quay.io/rubixx_cube/almalinux-ansible:10
```

### Container Setup

> [!warning]
> As Docker container this image needs to be run privileged with fully
> accessible cgroup mounts.
>
> This poses a potential security risk if untrusted code is run inside the
> container. Further customization might include specific system capabilities
> instead of full privileged access.

```bash
# podman
podman run --rm -d --name test quay.io/rubixx_cube/centosstream-ansible:10
# Docker
docker run --rm -d --name test \
    -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
    --cgroupns=host \
    --privileged \
    quay.io/rubixx_cube/almalinux-ansible:10
```
