
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