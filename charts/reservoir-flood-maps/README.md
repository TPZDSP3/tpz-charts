# Reservoir Flood Maps
## Deployed Architecture
The deployment is composed of:
- App, static files
- Metadata, static files
### App
The App deployment is just and ingress with it's service defining a blobstorage where the data can be found
### Metadata
The Metadata deployment is just and ingress with it's service defining a blobstorage where the data can be found
## Known deployment issues and challenges specific to the app
TODO
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| staticApp.vhost | dsptpzbuildartefacts.z33.web.core.windows.net | URL where the data resides  |
| staticApp.target | /tags/reservoir-flood-maps/0.3.0 | Folder where the data resides  |
| metadata.vhost | dsptpzbuildartefacts.z33.web.core.windows.net | URL where the data resides  |
| metadata.target | /tags/reservoir-flood-maps/0.3.0 | Folder where the data resides  |
## Secrets
No secrets