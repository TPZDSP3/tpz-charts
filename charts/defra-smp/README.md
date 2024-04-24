# Shoreline Managament Planning
## Deployed Architecture
The deployment is composed of:
- Fuseki database
- Web, connected to fuseki
- Nginx, loading the web with static files
- Processor to fill fuseki, create the tiling and documents
- PVC to store the tiles and documents created by the processor and be used by nginx
### Fuseki
The fuseki deployment is composed of:
- Fuseki service pointing to fuseki pod
- Fuseki pod
### Nginx loading the Web
The nginx and web deployment is composed of:
- Ingress pointing to the nginx service
- Nginx service pointing to Nginx pod
- Nginx pod pointing to Web service and static files via config file defined in the configmap with the tiles and documents PVC mounted
- Web service pointing to Web pod 
- Web pod pointing to fuseki instance
### Processor
The procesor is loaded in the nginx deployment as a sidecar container, this ensure us that the pods are in the same node and can be mounted with a **disk.csi.provisioner**

The first time it downloads the documents from a aws storage and put them in the proper folder for nginx. Inside the container a cronjob is installed to execute the tiling process every day

It checks for changes in shapefiles in environment.data.gov.uk and convert them into tiles to allow nginx to use them, it also updates the database when this changes occur

### PVC
This is a PVC that can be mounted by nginx and processor at the same time
## Known deployment issues and challenges specific to the app
- Due to performance, the shared PVC needs to be of **disk.csi.provisioner** type, this means that nginx and the processor need to be in the same node.
- When updating the nginx deployment, the new one won't be able to start if it is not using the same node as the old one, so we probably will have to kill it intead of use a Rolling Release
- The database load uses a lot of resources and sometimes get killed by Kubernetes
- A 500 in the web usually means that the database is not correct
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| processor.cronjobExpression | 0 2 * * * | When the processor is going to kick off (As a cron expresion)  |
| processor.data.storageClassName  | dev-tpzuk-disk-retain | Storage class name of processor and nginx PVC (ReadWriteOnce)  |
| processor.data.environment  | test | Folder to track our inputs in Azure container |
| web.enableNCERM | true | This flag enables the ncerm version in the web  |

## Secrets
**AGRIMETRICS_API_KEY** is used by the processor to download the shapefiles we need to create the tiles
**SAS_TOKEN**, **CONTAINER_NAME** and **ACCOUNT_NAME** are used to define the Blobstorage to upload our input files and check what we have downloaded