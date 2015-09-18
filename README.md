# SDH-Platform


Deploying the Smart Developer Hub platform with Docker or Vagrant.

## Intro
Dockerfiles, Docker-compose service definition and Vagranfile to deploy the SDH platform services using Docker.

Docker containers included:

- redis (populated with SCM data from 5 specific repositories)
- mredis (another redis container for all the data produced by the Agora and the Metrics services)
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
|Docker			|>= 1.3 		|works with Boot2docker 1.3						  |
|Docker-compose		|>= 1.1.0 		|on the host or with Dockerfile provided	  	|
|Vagrant		|>= 1.6 		|if you intend to use Vagrant				  	|
|OS				|any	 		|as long as you can run Docker 1.3 or Vagrant 1.6	  			|


## Reference

### Structure

...


### Files

...

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

## Configuration recipes

### ...


### License

SDH-Platform is distributed under the Apache License, version 2.0.
