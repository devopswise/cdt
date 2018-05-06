# dwtools
dwtools is a infrastructure as code project for testing self-hosted applications.

#### With dwtools you can
- kickstart your iaas project
- test your self-hosted application which requires ldap, smtp
- test your self-hosted application if it works behind proxy
- use it for educational purposes, then terminate your server after use, unless you keep your changes on code.
- use it to avoid cloud bills to run your dev environment
- it creates an enterprise like server environment, with LDAP, reverse proxy, web proxy, smtp relay etc.

## Getting Started

Easiest way to getting started is using docker installer [dwtools-installer](http://www.dropwizard.io/1.0.2/docs/).
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
docker run -d dwtools-installer --name dwtools-installer -e AWS_ACCESS_KEY_ID="your aws access key" -e AWS_SECRET_ACCESS_KEY="your aws secret access key"
```

After container starts running, you should
```
docker exec -it dwtools-installer bash
```

then type
```
# dwtools --launch
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Traefik](https://traefik.io/) - A modern http reverse proxy
* [Ansible](https://github.com/ansible/ansible) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

