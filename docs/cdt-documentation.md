# CDT Documentation

## 1. What is CDT?
CDT is an open source self hosted CI/CD toolchain for software teams. It is consist of most notable software development tools including Jenkins, Gitea, RocketChat etc.  Those tools are configured work together. It will install those tools, and configure them for you.

Beyond those integration, a very simple pipeline is already implemented on top of those tools.
CDT is for teams who doesn’t want to spare their time for installing managing and configuring those applications and focus on product they want to work on.

CDT has predefined personas, which makes easy to understand how it should be used. Those personas are:
Alice Developer (A), Bob Developer (B). Charlie Lead Developer (C) and they work on project hrweb. Hrweb project is a web application for human resource department.


## 2.Howto Install
[see README.md](https://github.com/devopswise/cdt/edit/master/README.md)

## 3. Administration
### Logs
you can find logs from all tools in /opt/cdt/docker-logs

### User & Project Management
You can use swagger UI to create or delete projects, create groups.


## 3.HOWTO DEVELOP & CONTRIBUTE

* copy roles/template folder
* change default vars.yml with correspondingly
* create a template for docker-compose.yml
* create playbook/app-name.yml
* create pull request

## 4. Default Advised Practices
Here is advised lifecycle for CDT.
#### Basic lifecycle without release 
Current state is 1.0.0, deployed in all environments, tagged as 1.0.0 on master branch, which is equal to development (hrweb.com)
Alice checkout development branch. Creates her feature1 branch. Her task is to change time format in hrweb.
After creating a branch she pushes to git. Jenkins detect branch and compiles and publish to feature1.hrweb.com. In nexus feature1 branch gets created. #feature1 chatroom gets created with alice and deploy bot (and who else?)
She works locally, make her changes, then push again. (1.0.0.feature1-1)Code updated and Jenkins deploy again.
When feature1 is completed. Alice creates a pull request. This is announced in chatroom.
Charlie merge feature1 into development. Then automatically Jenkins publish to dev.hrweb.com
After each deployment smoke tests run and and notify user with email/chat if fails. Reports are stored on nexus.


#### SIMPLE LIFECYCLE- release cycle
Alice create a release_1.0.1 branch from development
If there is few more changes on it can be done on this release_1.0.1 branch
After deployment release branch merges to the master and development, then master become deployable. After branch is merged artifacts are deleted.

#### SIMPLE LIFECYCLE- hotfix
If there is a hotfix need to be applied new branch hotfix_1.0.1 is created from master, deployed to master and it gets merged both development and master.

#### SIMPLE LIFECYCLE – artifacts
Artifacts should be able to produced if one run main build.

### 4.1 OVERVIEW
### 4.2 BRANCHING
### 4.3 DEPLOYMENT

SIMPLE LIFECYCLE- deploy

Deploy(version,env) if env is null, it is deployed to dev (isolated feature1.cdt.devopswise.co.uk)
There should be one package build and deployment build.
Jenkins show env versions environments dashboard plugin

SIMPLE LIFECYCLE

BUILD
UNIT
STATIC
PACKAGE
AUTOTEST (enabled for DEV & MASTER)


### 4.4 PLANNING & RELEASE

### 4.5 MONITORING & INSTRUMENTING
Grafana, Prometheus and prometheus push gateway comes, preinstalled.
Access it here: grafana.yourdomain.com

You can use prometheus & grafana to instrument your applications. see prometheus exporters here [prometheus exporters](https://prometheus.io/docs/instrumenting/exporters/)

