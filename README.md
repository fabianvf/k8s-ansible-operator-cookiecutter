## Basic Usage
```
molecule init template --url https://github.com/fabianvf/k8s-ansible-operator-cookiecutter
```
or 
```
cookiecutter https://github.com/fabianvf/k8s-ansible-operator-cookiecutter
```
and follow the prompts to set the required parameters.

## Requirements
- Docker must be installed on your system
- You will also need the following python packages:
  - `molecule`
  - `docker`
  - `openshift`

## Description
This repo is a cookiecutter template for generating an Ansible Operator scaffold.
It will initialize a basic Ansible role, as well as three molecule scenarios.
To execute a molecule scenario, you can run `molecule converge` or
`molecule test`. `molecule test` will spin up a new kind instance, execute
`playbook.yml`, and then tear down the cluster. `molecule converge` will bring
up a kind instance, run the `playbook.yml`, and then exit. For development,
`converge` will provide a much faster testing loop, but `test` is a better
verification is should be used in test scripts/etc. By default molecule will target
the default scenario, if you want to target one of other scenarios, run
`molecule converge -s <scenario>` or `molecule test -s <scenario>` instead.

The first scenario, `default`, is intended for use during role development.
It will spin up a (Kubernetes-in-Docker (kind))[https://github.com/bsycorp/kind]
cluster and run the initialized role against that cluster. You can add asserts
to the end of `<role_name>/molecule/default/playbook.yml` to verify the state
of your cluster.

The second scenario, `test-local` is a more thorough end-to-end test of your
operator. It will bring up a kind cluster, build your operator image and make it
available to that cluster, create the CRD, namespace and various RBAC resources,
and then spin up your operator and create in instance of your CR. You can add
asserts to the end of `<role_name>/molecule/test-local/playbook.yml` to verify
that your operator is performing the actions you expect.

The third scenario, `test-cluster` is intended to integrate into existing 
end-to-end test suites. I'm not yet sure what it will do. WIP

To use this cookiecutter template to initialize a new role, you can run
`molecule init template --url https://github.com/fabianvf/k8s-ansible-operator-cookiecutter` and
follow the prompts to select your `APP_NAME`, `GROUP`, `VERSION`, and `KIND`
This will init an operator with the following structure (sub in the variables mentioned above with your selections):

```
$APP_NAME
├── build
│   └── Dockerfile
├── deploy
│   ├── crds
│   │   ├── $GROUP_$VERSION_$KIND_crd.yaml
│   │   └── $GROUP_$VERSION_$KIND_cr.yaml
│   ├── operator.yaml
│   ├── role_binding.yaml
│   ├── role.yaml
│   └── service_account.yaml
├── roles
│   └── $KIND
│       ├── defaults
│       │   └── main.yml
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── molecule
│       │   ├── default
│       │   │   ├── INSTALL.rst
│       │   │   ├── molecule.yml
│       │   │   ├── playbook.yml
│       │   │   └── prepare.yml
│       │   └── test-local
│       │       ├── INSTALL.rst
│       │       ├── molecule.yml
│       │       ├── playbook.yml
│       │       └── prepare.yml
│       ├── README.md
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       └── vars
│           └── main.yml
└── watches.yaml
```

To run a molecule command, just `cd` to `$APP_NAME/roles/$KIND/`, then you can run any molecule command and it will be able to properly locate the scenarios.
