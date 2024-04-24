# Rural Payments Agency
## Deployed Architecture
The deployment is composed of:
- MongoDB database
- APP, connected to MongoDB
- [Geoserver](../geoserver/README.md)
### MongoDB
The MongoDB deployment is composed of:
- MongoDB service pointing to MongoDB pod
- MongoDB pod
### APP
The APP deployment is composed of:
- Ingress pointing to the APP service
- APP service pointing to APP pod
- APP pod pointing to MongoDB instance
## Known deployment issues and challenges specific to the app
TODO 
## Important Values 
|  Value | Default  | Explanation  |
|---|---|---|
| geoserverUrl | dsp-test.agrimetrics.co.uk/data-services | The URL of geoserver  |
## Secrets
**MONGO_USER** and **MONGO_PASS** need to be pass as a secret, they are the credentials for the APP to connect to mongo
**API_KEY** needs to be pass as a secret, it is the key to extract data from the database using the APP