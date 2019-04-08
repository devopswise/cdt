# CDT (Continous Delivery Toolchain)
CDT is continuous deliver toolchain project based on 5 tool.
They are Jenkins, Gitea, RocketChat and Grafana

cdt install continuous delivery tools on your server and configure those applications to run together.
For example, when you push your code into Gitea, Jenkins start building it. This comes preconfigured.

This project aims to have best tools of ci/cd industry and most favorite integrations between them.

## Features
- cdt comes with sample persona's puppets. like Alice Developer, Charlie Lead Developer. Their access rights and user accounts also come preconfigured.
- cdt is also suitable for training.
- cdt installs a proxy server (traefik) so you can access like jenkins.yourdomain.com etc.
- cdt generates a https certificate (either ss, or using lets encrypt)
- all communication between tools and outside world are over https.
- cdt installs a common ldap directory and create testing users on this directory.
- passwords if this users are generated here under credentials dir.
- all sdlc apps are configured to use ldap.
- gitea, rocket chat comes bootstrapped for you.
- ec2 instance is isolated, created and secured.
- only required ports leaved open, other firewalled.
- to access ec2 server a ssh provate key had generated and keept locally only on this server.
- an smtp relay gets installed and configured to use gmail.
- cdt configures outgoing mail for all tools. so apps can send notifications to team.
- all application data created by the tools is persisted and located on /opt/docker-volumes, so it is easy to backup, migrate
- cdt install prometheus and grafana and creates grafana dashboards for tools.
- grafana can also be used to monitor applications created by team.
- cdt uses official docker images for tools and tools can be updated easily.
- when a self signed cert is generated, all apps made trust the grnerated certificate.


## Getting Started
Easiest way to getting started is using docker installer [cdt-installer](https://hub.docker.com/r/devopswise/cdt-installer/).
it launches an ec2 instances(t2.medium), then runs ansible code to install applications. 
You will end up with:
 - a workspace in your docker instance
 - sample wordpress application up and running
 - a secured ec2 server accessible with ssh, where you can run your changes. 
 - your pem file, downloaded into your workspace

### Prerequisites

- your aws access keys
- any docker installed system

### Installing
However it is not a requirement if you want to run on already-existing server.

```
docker run -d --name cdt-installer -e AWS_ACCESS_KEY_ID="your aws access key" -e AWS_SECRET_ACCESS_KEY="you aws secret" devopswise/cdt-installer:latest
```

After container starts running in background, you should
```
docker exec -it cdt-installer bash
```
```
Type 'cdt --launch' to install cdt for the first time
have fun!
root@3b749e89f113:/#
```

then type
```
root@3b749e89f113:/# cdt --launch
               _     _
              | |   | |
   ___      __| |   | |_
  / __|    / _` |   | __|
 | (__    | (_| |   | |_
  \___|    \__,_|    \__|

Launching cdt...
Cloning into '/opt/cdt/master'...
remote: Enumerating objects: 242, done.
remote: Counting objects: 100% (242/242), done.
remote: Compressing objects: 100% (146/146), done.
remote: Total 819 (delta 100), reused 185 (delta 59), pack-reused 577
Receiving objects: 100% (819/819), 288.77 KiB | 0 bytes/s, done.
Resolving deltas: 100% (363/363), done.
Checking connectivity... done.
generating new key-pair : cdt-20190408174854
creating new ec2 instance
A new EC2 instance is created instance_id:i-00f025e986e062bc1
waiting i-00f025e986e062bc1 to become alive:
.... running
public_ip=34.244.161.83
using xip.io for fqdn
ansible-playbook -i /opt/cdt/master/inventories/pro /opt/cdt/master/site.yml --vault-password-file=/opt/cdt/master/ansible-vault-pass
/
...
...
SERVER_FQDN=34.244.161.83.xip.io
PUBLIC_IP=34.244.161.83
PEM_FILE=/opt/cdt/master/cdt-20190408174854.pem
KEY_PAIR=cdt-20190408174854
provisioning completed.

cdt installed on 34.244.161.83.xip.io, you can now access tools at www.34.244.161.83.xip.io
server will be terminated automatically in 2 hours, incase you forgot to terminate it
if you want to develop or dig around, get into cdt-installer container first
docker exec -it cdt-installer bash

 you can always share your thoughts on info@devopswise.co.uk[
/# 
```

![AWS Instance provisioned](https://raw.githubusercontent.com/devopswise/cdt/master/resources/images/aws-instance-provisioning.png)

End with an example of getting some data out of the system or using it for a demo

## Screenshots
<img src="https://raw.githubusercontent.com/devopswise/cdt/master/resources/images/jenkins-with-other-tabs.png">
<img src="https://raw.githubusercontent.com/devopswise/cdt/master/resources/images/puppet-users.png" width="300"><img src="https://raw.githubusercontent.com/devopswise/cdt/master/resources/images/grafana-dashboard-traefik.png" height="600">

## Persistence
Regarding data files or configuration files created by this installation, everything stored on /opt folder on aws instance (or your vm). 

__It will be removed if you use cdt --terminate command.__


Regarding persistence source code changes of cdt;
cdt-installer keep changes, target specific data, passwords and changes on /opt/dwtools. 
It is better to mount it to /opt/dwtools on host machine.

```
docker run -v /opt/cdt:/opt/cdt -d devopswise/dwtools-installer:latest --name dwtools-installer -e AWS_ACCESS_KEY_ID="your aws access key" -e AWS_SECRET_ACCESS_KEY="your aws secret access key"
```

### Passwords for applications
All passwords are generated at first launch and you can find them, /opt/cdt/master/credentials/ directory.

```
# ls /opt/cdt/master/credentials/
traefik_admin_pass  traefik_admin_pass_hash_md5  wordpress_db_pass openldap_persona_alice_pass openldap_persona_bob_pass
```

### Terminating AWS resources properly

You can always type dwtools --terminate if you want to remove VPC, subnet, internet gateway etc.

```
root@3b749e89f113:/# cdt --terminate
This will remove target server, you can always re-launch,
a new server but you will lose data inside it if you didn't backup
Do you wish to terminate server? (y/n)y
..............
root@3b749e89f113:/#
```

## SSH to target instance
```
root@3b749e89f113:/# cdt --ssh
Last login: Mon Apr  8 17:59:34 2019 from ec2-34-240-174-XX.eu-west-1.compute.amazonaws.com
18:03:44 centos@ip-10-0-0-9:~$ 
```

## List of running containers
```
root@3b749e89f113:/# cdt --ssh
18:20:47 root@ip-10-0-0-9:centos$ docker ps
CONTAINER ID        IMAGE                                   NAMES
3302fb981460        devopswise/cdtportal:latest             cdtportal_cdtportal_1
50543f595c14        rocketchat/rocket.chat:1.0.0-rc.0       rocketchat_rocketchat_1
308b21869920        rocketchat_mongodb                      rocketchat_mongodb_1
f4f42bfafb2d        gitea/gitea:1.8                         gitea_gitea_1
2234e2025eac        mariadb:10.3                            gitea_mysql_1
568de08be5eb        grafana/grafana:5.2.1                   grafana_grafana_1
f9b421a147d1        devopswise/prometheus:latest            grafana_prometheus_1
3290d10fcfc0        quay.io/prometheus/pushgateway:latest   grafana_pushgateway_1
be903bfe31c9        devopswise/jenkins:latest               jenkins_jenkins_1
1c8084f71cda        accenture/adop-ldap-ltb:0.1.0           openldap_ldap-ltb_1
3032743193c1        accenture/adop-ldap:0.1.3               openldap_ldap_1
586b7ddd3432        namshi/smtp:latest                      smtprelay_smtp_1
efe4876dd123        sameersbn/squid:3.3.8-23                squid_web_proxy_1
d55b507dd4e4        traefik:1.7.4                           traefik_traefik_1
```

## Built With

* [Gitea](https://gitea.io) - A painless self-hosted Git service
* [Jenkins](https://jenkins.io) - The leading open source automation server
* [RocketChat](https://rocket.chat/) - Rocket.Chat is free, unlimited and open source ultimate team chat software
* [Grafana](https://grafana.com/) - The open platform for beautiful 
analytics and monitoring
* [Prometheus](https://prometheus.io/) - Monitoring system & time series database
* [Traefik](https://traefik.io/) - A modern http reverse proxy
* [OpenLDAP](https://www.openldap.org/) - A modern http reverse proxy
* [docker-compose](https://docs.docker.com/compose/) - A tool for defining and running multi-container Docker applications
* [Ansible](https://github.com/ansible/ansible) - IT Automation/Configuration Management
* [DebianExim4](https://github.com/namshi/docker-smtp) - SMTP Relay
* [Gitea](https://gitea.io) - A painless self-hosted Git service
* [Squid Web Proxy](http://www.squid-cache.org/) - Web Proxy


## Contributing
We welcome improvements and ideas!

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

