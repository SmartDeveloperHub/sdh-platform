# SDH-Platform
Deploying the Smart Developer Hub platform with Docker or Vagrant.

## Intro
Dockerfiles, Docker-compose service definition and Vagranfile to deploy the SDH platform services using Docker.

Docker containers included:

- redis (populated with SCM data from 5 specific repositories)
- mredis (another redis container that stores all data produced by the Agora and the Metrics services)
- enhancer ([GitLab Enhancer](https://github.com/SmartDeveloperHub/gitlab-enhancer), boosts and enhances the access to the SCM data located in a GitLab instance)
- scmharvester ([SCM Harvester](https://github.com/SmartDeveloperHub/sdh-scm-harvester), publishes SCM information gathered from GitLab instances)
- ciharvester ([CI Harvester](https://github.com/SmartDeveloperHub/sdh-ci-harvester), gathers and publishes CI information from Jenkins instances)
- fountain ([Agora Fountain](https://github.com/SmartDeveloperHub/agora-fountain), performs ontology paths discovery and seed management)
- planner ([Agora Planner](https://github.com/SmartDeveloperHub/agora-planner), provides search plans for graph patterns)
- fragment (An Agora Planner whose only purpose is to provide fragments for a given graph pattern)
- scmmetrics ([SCM Metrics](https://github.com/SmartDeveloperHub/sdh-scm-metrics), calculates a small set of quantitative metrics on data from the software control management domain)
- cimetrics ([CI Metrics](https://github.com/SmartDeveloperHub/sdh-ci-metrics), calculates a small set of quantitative metrics on data from the continuous integration domain)
- nginx (nginx-extras container as a caching reverse proxy)
- ldap (Users directory to authenticate request from the API)
- sdhapi ([SDH API Swagger API](https://github.com/SmartDeveloperHub/sdh-api), provides metrics and context information about organizations, users and projects)

## Requirements
|Name			|Version		|Comment										  |
|:--------------|:-------------:|:------------------------------------------------|
|Docker			|\>= 1.6 		|works with Boot2docker 1.3						  |
|Docker-compose	|\>= 1.1.0 		|on the host or with Dockerfile provided	  	  |
|Vagrant		|\>= 1.6 		|if you intend to use Vagrant				  	  |
|OS				|any	 		|as long as you can run Docker 1.6 or Vagrant 1.6 |

## Reference
### Structure
	├── README.md
	├── Vagrantfile (*SDH Vagrantfile*)
	├── docker-compose.yml (*SDH services definition*)
	├── vagrant
	│   ├── provision.sh (*Keeep SDH repository updated and builds docker images*)
	│   └── always.sh (*Up containers & no-recreate*)
	├── ciharvester
	│   ├── Dockerfile (*Extends [smartdeveloperhub/sdh-ci-harvester-docker](https://hub.docker.com/r/smartdeveloperhub/sdh-ci-harvester-docker/)*)
	│   └── my_init.d/A1_init (*Self-registration in the Agora as a seed*)
	├── scmharvester
	│   ├── Dockerfile (*Extends [smartdeveloperhub/sdh-scm-harvester-docker](https://hub.docker.com/r/smartdeveloperhub/sdh-scm-harvester-docker/)*)
	│   └── my_init.d/A1_init (*Self-registration in the Agora as a seed*)
	├── redis
	│   ├── Dockerfile (*Extends redis image copying the dump*)
	│   └── dump_db0_gitlab.rdb (*Redis dump containing data from 5 GitHub repositories*)
	├── mredis
	│   ├── Dockerfile (*Extends redis image copying the Agora data dump and the corresponding Sleepycat graph*)
	│   ├── graph/ (*Sleepycat graph of the SDH vocabularies*)
	│   └── dump.rdb (*Redis dump containing data from 5 GitHub repositories*)
	├── ldap
	│   ├── Dockerfile (*Docker image containing an LDAP server*)
	│   └── configuration/ (*LDAP configuration files*)
	├── scmmetrics
	│   ├── Dockerfile (*Extends [smartdeveloperhub/sdh-scm-metrics-docker](https://hub.docker.com/r/smartdeveloperhub/sdh-scm-metrics-docker/)*)
	│   └── my_init.d/A1_init (*Self-registration in the Agora as a seed*)
	└── cimetrics
	│   ├── Dockerfile (*Extends [smartdeveloperhub/sdh-ci-metrics-docker](https://hub.docker.com/r/smartdeveloperhub/sdh-ci-metrics-docker/)*)
	│   └── my_init.d/A1_init (*Self-registration in the Agora as a seed*)

### Files
#### Dockerfiles
All container images are based on `phusion/baseimage`.

#### Vagrantfile
Defines a VM that comes with Docker and docker-compose installed. It should be used if the host can't run Docker containers natively.

#### docker-compose.yml
Defines the set of services required to run the Smart Developer Hub platform. Read the [docker-compose.yml reference](http://docs.docker.com/compose/yml/) to understand and edit.

## Usage
1. Run `up` with Docker-compose or Vagrant

### Using Docker-compose (recommended)

#### First-time run

If you have docker-compose installed, just type

	docker-compose up -d

The latter command builds (if the images were not present) and creates or recreates (erases all previously generated data) the containers.

#### Stopping containers

In case you decide to stop any container, simply run the following command adding the name of the container (omit to stop all of them).

	docker-compose stop <container_name>

#### Starting containers

You may need to start containers after a previous explicitly commanded stop, either selective or not. To do so, just type

	docker-compose start <container_name>

If you don't specify any container, docker-compose will start all stopped containers.

### Using Vagrant

The specific command to build and run the Vagrant VM is

	vagrant up

Vagrant creates a [VM](https://atlas.hashicorp.com/alejandrofcarrera/boxes/trusty64-docker) that contains Docker and docker-compose out of the box. In case you need to manage any of the aforementioned containers, just type `vagrant ssh` and proceed as explained in section *Using Docker-compose*.

### License

SDH-Platform is distributed under the Apache License, version 2.0.
