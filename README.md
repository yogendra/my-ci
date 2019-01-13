# CI - Soup to Nuts

This project creates a full CI/CD system. It has:

* Concourse : For CI
* Gogs: SCM system
* Artifactory OSS: Artifact repository
* SonarQube: Code quality check

REQUIRED: direnv
## How to get started

* Clone this repository
* Change to directory
* If you don't have direnv on you system, just do `source .envrc`. 
* Create Docker-Mahcine : `docker-machine create $DOCKER_MACHINE_NAME`
* Run Docker Copose: `docker-compose up -d`


## Cleanup

* docker-compose down
* docker-machine rm -f $DOCKER_MACHINE_NAME
