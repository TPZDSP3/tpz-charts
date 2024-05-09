# Geoserver (RPA and DW)
## Deployed Architecture
The deployment is composed of:
- Geoserver deployment
- Cronjob for RPA data ingestion
- Job for DW ingestion
- Blobstorage to get the RPA data
- PVC copy the data
### Geoserver
The geoserver is composed of:
- Ingress pointing to the geoserver service
- Geoserver service pointing to geoserver pod
- Geoserver pod with data directory PVC mounted
- Updated Status API to show when the RPA was updated for the last time
### Job for DW
The Job creates the workspace, datastore, styles and loads the shapefiles for them
### Cronjob for RPA
The cronjob checks for a new geopackage in the blobstore, index it, copy it to the data directory in geoserver and configures geoserver to use it
## Known deployment issues and challenges specific to the app
- If the data directory PVC gets full, the system won't get updates and geoserver will get blocked
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| dataIngestionDW.pdfsUrlSW | https://url | URL where the pdfs for Surface Water are located  |
| dataIngestionDW.pdfsUrlGW | https://url | URL where the pdfs for Ground Water are located  |
| dataIngestionDW.pdfsUrlNVZ | https://url | URL where the pdfs for Nitrate are located  |
| dataIngestionRPA.cronjobExpression | 0 2 * * *| When the data ingestion for RPA is going to kick off (As a cron expresion) |
| dataIngestionSCI.cronjobExpression | 0 3 * * * | When the data ingestion for SCI is going to kick off (As a cron expresion) |
## Secrets
**GEOSERVER_ADMIN_USER**, and **GEOSERVER_ADMIN_PASSWORD** are used to define the user and password of geoserver admin gui