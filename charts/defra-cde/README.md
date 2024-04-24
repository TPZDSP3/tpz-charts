# Catchment and Data Explorer
## Deployed Architecture
The app has a **green/blue deployment**, this means that one deployment can be updated meanwhile the other is servin data in live.
The deployment is composed of:
- Graphdb instance, this instance is external to the chart, located in AGM network
- App, connected to graphdb
- Varnish cache server, to speed up queries from the App
- Processor to fill Graphdb and app cache files
- Blobstorage to store the CSV files created by the processor and used by the app
### APP with Varnish
The APP deployment is composed of:
- Ingress pointing to the varnish service
- Varnish service pointing to Varnish pod
- Varnish pod pointing to APP service via config file defined in the configmap
- APP service pointing to APP pod
- APP pod pointing to Graphdb instance
- APP pod mounting a PVC with the data collected in the processor (blobstorage)
### Processor
The processor is a job that is executed once a day to prepare the data is going to be ingested into Graphdb and the APP
### Blobstorage
This is a PVC with a storage class that is pointing to an storage account in Azure 
## Known deployment issues and challenges specific to the app
TODO 
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| graphEndpoint | http://localhost:7200/repositories/defra-efde | Graphdb endpoint including the repository name |
| cache.storageClassname  | premiumssdv2-zrs-delete | Storage class is going to be used to load the data |

## Secrets
In our test deployment there are no secrets but in TEST and LIVE in he AGM cluster the value **API_ENDPOINT** needs to be passed as a secret as the connection string has the user and password to connect to AGM graphdb