

# Important Note
## documentation is in progress, you should checkout [dwtools project](https://github.com/devopswise/dwtools.git) if you want to try out.



# CDT (Continous Delivery Toolchain)
cdt is continuous delivery toolchain based on Jenkins and Github.

cdt install continuous delivery tools on your server and configure those applications to run together.
For example, when you push your code into github, jenkins start building it. This comes preconfigured.

Meanwhile, project aims to have best tools of ci/cd industry and most favorite integrations between them.

#### With cdt you can
- kickstart your web application project from zero to deployment, just by cloning a reference project.
- each branch is isolated and has it is own endpoint. if you use feature1 branch, it will deploy deploy to feature1.yourdomain.com
- cdt comes with sample persona's puppets. like Alice Developer, Charlie Lead Developer. Their access rights and user accounts also come preconfigured.
- cdt is also suitable for training.

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
docker run -d --name dwtools-installer -e AWS_ACCESS_KEY_ID="your aws access key" -e AWS_SECRET_ACCESS_KEY="you aws secret" devopswise/dwtools-installer:latest
```

After container starts running in background, you should
```
docker exec -it dwtools-installer bash
```

then type
```
# dwtools --launch
      _          _              _
     | |        | |            | |
   __| |_      _| |_ ___   ___ | |___
  / _` \ \ /\ / / __/ _ \ / _ \| / __|
 | (_| |\ V  V /| || (_) | (_) | \__ \
  \__,_| \_/\_/  \__\___/ \___/|_|___/

Launching dwtools...
Cloning into '/opt/dwtools/master'...
remote: Counting objects: 131, done.
remote: Compressing objects: 100% (100/100), done.
remote: Total 131 (delta 33), reused 83 (delta 5), pack-reused 0
Receiving objects: 100% (131/131), 114.09 KiB | 0 bytes/s, done.
Resolving deltas: 100% (33/33), done.
Checking connectivity... done.
generating new key-pair : dwtools-20180508230154
creating new ec2 instance
A new EC2 instance is created instance_id:i-0ef3e3859dfdc29a7
waiting i-0ef3e3859dfdc29a7 to become alive:
...
...
...
dwtools installed on 34.245.139.72.xip.io, you can access tools www.34.245.139.72.xip.io
server will be terminated automatically in 2 hours, incase you forgot to terminate it
get into dwtools-installer container first
docker exec -it dwtools-installer bash
then, you can either sssh to your instance by typing
ssh -i /opt/dwtools/master/dwtools-20180508231143.pem centos@34.245.139.72.xip.io
or you can modify ansible code in /opt/dwtools/master, then apply changes by typing,
ansible-playbook -i /opt/dwtools/master/inventories/pro /opt/dwtools/master/site.yml -vv --vault-password-file=/opt/dwtools/master/ansible-vault-pass
/# 
```

End with an example of getting some data out of the system or using it for a little demo

## Persistence

dwtools-installer keep changes, target specific data, passwords and changes on /opt/dwtools. 
It is better to mount it to /opt/dwtools on host machine.

```
docker run -v /opt/dwtools:/opt/dwtools -d devopswise/dwtools-installer:latest --name dwtools-installer -e AWS_ACCESS_KEY_ID="your aws access key" -e AWS_SECRET_ACCESS_KEY="your aws secret access key"
```

### Passwords for applications
All passwords are generated at first launch and you can find them, /opt/dwtools/master/credentials/ directory.

```
# ls /opt/dwtools/master/credentials/
traefik_admin_pass  traefik_admin_pass_hash_md5  wordpress_db_pass
```

### Terminating AWS resources properly

You can always type dwtools --terminate if you want to remove VPC, subnet, internet gateway etc.

```
root@03b6f7de6519:/# dwtools --terminate
This will remove target server, you can always re-launch,
a new server but you will lose data inside it if you didn't backup
Do you wish to terminate server?y
..............
root@03b6f7de6519:/#
```

## SSH to target instance
```
root@03b6f7de6519:/# dwtools --ssh
Last login: Tue May  8 23:16:36 2018 from ec2-34-240-174-240.eu-west-1.compute.amazonaws.com
23:17:07 centos@ip-10-0-0-5:~$ 
```

Add additional notes about how to deploy this on a live system

## Built With

* [Traefik](https://traefik.io/) - A modern http reverse proxy
* [OpenLDAP](https://www.openldap.org/) - A modern http reverse proxy
* [docker-compose](https://docs.docker.com/compose/) - A tool for defining and running multi-container Docker applications
* [Ansible](https://github.com/ansible/ansible) - IT Automation/Configuration Management
* [DebianExim4](https://github.com/namshi/docker-smtp) - SMTP Relay
* [Wordpress](https://github.com/WordPress/WordPress) - As sample application and documentation of project
* [Squid Web Proxy](http://www.squid-cache.org/) - Web Proxy


## Contributing
We welcome improvements and ideas!

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

