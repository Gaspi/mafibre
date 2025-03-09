# MaFibre

## Configuration
TODO


## Create PM tiles

```sh


mkdir data
cd data

# Download immeubles 2024T3
wget https://www.data.gouv.fr/fr/datasets/r/4f213bb4-222b-4b27-8751-07cf99840fd8 -O immeubles_2024_t3.zip
unzip immeubles_2024_t3.zip
rm immeubles_2024_t3.zip

# Tippecanoe installation
sudo apt-get install libsqlite3-dev libz-dev
git clone https://github.com/mapbox/tippecanoe.git
cd tippecanoe
make -j
sudo make install
cd ..

# MBtiles generation with Tippecanoe
tippecanoe -o carte_fibre_immeubles_2024_t3.mbtiles -l fibre -zg --drop-densest-as-needed --extend-zooms-if-still-dropping -T batiment:string -T code_insee:string -T code_poste:string carte_fibre_immeubles_2024_3_20241106.csv

# pmtiles tool installation
wget https://github.com/protomaps/go-pmtiles/releases/download/v1.25.3/go-pmtiles_1.25.3_Linux_x86_64.tar.gz -O pmtiles.tar.gz
tar -zxf pmtiles.tar.gz
rm pmtiles.tar.gz

# MBtiles conversion to PMtiles
./pmtiles convert carte_fibre_immeubles_2024_t3.mbtiles carte_fibre_immeubles_2024_t3.pmtiles
```


## Host PM tiles on S3

```sh
S3_BUCKET=$(echo $KUBERNETES_NAMESPACE | cut -d '-' -f 2)
mc cp carte_fibre_immeubles_2024_t3.pmtiles s3/$S3_BUCKET/pmtiles/carte_fibre_immeubles_2024_t3_bis.pmtiles
mc anonymous set download s3/$S3_BUCKET/pmtiles/carte_fibre_immeubles_2024_t3.pmtiles
```


## Compile and host frontend

```sh
npm install .
```

## Get started on SSPCloud

- [Using VSCode and Python](https://datalab.sspcloud.fr/launcher/ide/vscode-python?name=mafibre&version=2.2.2&s3=region-ec97c721&resources.requests.cpu=%C2%AB2000m%C2%BB&resources.requests.memory=%C2%AB32Gi%C2%BB&persistence.size=%C2%AB50Gi%C2%BB&init.personalInit=%C2%ABhttps%3A%2F%2Fraw.githubusercontent.com%2FGaspi%2Fmafibre%2Frefs%2Fheads%2Fmain%2Finit-scripts%2Fvscode-python.sh%C2%BB&networking.user.enabled=true&networking.user.ports[0]=8080&discovery.hive=false&discovery.mlflow=false&discovery.metaflow=false)
