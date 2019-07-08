# Administration

## Architecture
- All applications in CDT is runs inside docker containers
- In the current setup all of them runs from single VM, for the sake of easier configuration/development
- Each workspace has its own network like theia-xyz
- All cdt app's runs inside cdt network
- Authentication & SSO is accomplished with Keycloak
- Traefik is the reverse proxy
- CDTPortal app, configures apps's and manages applications.

<img src="https://raw.githubusercontent.com/devopswise/cdt/sso/resources/images/cdt-diagram.png" width="900">
<p float="left">

## Upgrading Apps
- This should be done by changing app_image_version varibles. All apps are based on their official images.

## Backup/Restore
- All application data resides on /opt/cdt-data folder, having back-up of this directory will help you to restore applications.
- You can also back-up and restore by application, such as /opt/cdt-data/gitea

## Viewing Logs
- Logs are saved to /opt/cdt-log folder. Specifically /opt/cdt-log/docker/container_name/*

