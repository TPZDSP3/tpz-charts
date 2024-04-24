# Water Quality Archive
## Deployed Architecture
The deployment is composed of:
- Fuseki database
- API, connected to fuseki
- UI, connected to the API
- Varnish cache server, to speed up queries from the API
- Processor to fill fuseki and API cache files
- PVC to store the database created by the processor and used later by fuseki, along the cache files used by the API
### Fuseki
The fuseki deployment is composed of:
- Fuseki service pointing to fuseki pod
- Fuseki pod mounting a PVC with the database produced by the processor
### UI calling the API via Varnish
The UI deployment is composed of:
- Ingress pointing to the UI service
- UI service pointing to UI pod
- UI pod pointing to Varnish service via environment variable
- Varnish service pointing to Varnish pod 
- Varnish pod pointing to API service via config file defined in the configmap
- API service pointing to API pod
- API pod pointing to fuseki instance
### Processor
The processor is a cronjob that is executed once a day to update the cache files in the API and the database in fuseki.
It is composed by an initContainer that does all the work (prepare the data, imports it in a non-live database and creates the new cache data). Then when everything is done, it swaps the live with non-live and the main container restart the fuseki database to pick up the changes
### PVC
This is a PVC that can be mounted by fuseki, api and processor at the same time
## Known deployment issues and challenges specific to the app
TODO 
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| processor.cronjobExpression | 0 2 * * * | When the processor is going to kick off (As a cron expresion)  |
| processor.azureBlobUrl | https://dsp3data.blob.core.windows.net | Blobstorage url to push the data  |
| processor.azureBlobPath |  | The folder where the data is store in the azure blob  |

## Secrets
**AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY** need to be pass as a secret, they are the credentials that the processor needs to get the new data 
**AZ_BLOB_DATA_SAS** needs to be pass as a secret, it is the credential where the data is uploaded to be accessible as static files 