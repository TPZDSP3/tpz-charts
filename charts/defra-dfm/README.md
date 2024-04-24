# Data Flow Mapping
## Deployed Architecture
The deployment is composed of:
- Graphdb database
- APP, connected to the graphdb database
### Graphdb
The Graphdb deployment is composed of:
- Graphdb service pointing to Graphdb pod
- Graphdb pod
### APP
The APP deployment is composed of:
- Ingress pointing to the APP service
- APP service pointing to APP pod
- APP pod pointing to the graphdb database via environment variable
## Known deployment issues and challenges specific to the app
TODO
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| app.auth.callbackUrl | https://data-flow-mapping.dev-tpz-apps.tpzdsp3.com/auth-token | Callback url to be checked by the auth server (external) This needs to be configured in the auth server too  |


## Secrets
It should have the **auth secret** and **id** as a secret but as it is a dev app, it is hardcoded in the docker image at the moment