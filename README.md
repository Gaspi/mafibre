# MaFibre

## Configuration
TODO


## Create tiles

```sh
cd data
# Immeubles 2024T3
wget https://www.data.gouv.fr/fr/datasets/r/4f213bb4-222b-4b27-8751-07cf99840fd8 immeubles_2024_t3.zip
unzip immeubles_2024_t3.zip


wget https://github.com/protomaps/go-pmtiles/releases/download/v1.25.3/go-pmtiles_1.25.3_Linux_x86_64.tar.gz
tar -zxf go-pmtiles_1.25.3_Linux_x86_64.tar.gz

sudo apt-get install libsqlite3-dev libz-dev
git clone https://github.com/mapbox/tippecanoe.git
cd tippecanoe
make -j
sudo make install

tippecanoe -o carte_fibre_immeubles_2024_t3.pmtiles carte_fibre_immeubles_2024_3_20241106.csv

S3_BUCKET=$(echo $KUBERNETES_NAMESPACE | cut -d '-' -f 2)
mc cp carte_fibre_immeubles_2024_t3.pmtiles s3/$S3_BUCKET/pmtiles/carte_fibre_immeubles_2024_t3.pmtiles
mc anonymous set download s3/$S3_BUCKET/pmtiles/carte_fibre_immeubles_2024_t3.pmtiles
```


## Host on S3

```sh
TODO
```


## Compile and host frontend

```sh
npm install .
```

## Get started on SSPCloud

- [Using VSCode and Python](https://datalab.sspcloud.fr/launcher/ide/vscode-python?name=mafibre&version=2.2.2&s3=region-ec97c721&resources.requests.cpu=«2000m»&resources.requests.memory=«32Gi»&persistence.size=«50Gi»&init.personalInit=«https%3A%2F%2Fraw.githubusercontent.com%2FGaspi%2Fmafibre%2Frefs%2Fheads%2Fmain%2Finit-scripts%2Fvscode-python.sh»&networking.user.enabled=true&networking.user.ports[1]=8081&networking.user.ports%5B0%5D=8080&discovery.hive=false&discovery.mlflow=false&discovery.metaflow=false&autoLaunch=true)
