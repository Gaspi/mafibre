
sudo apt update -y
sudo apt upgrade -y
sudo apt install nodejs npm -y


git clone https://github.com/Gaspi/mafibre.git
cd mafibre
npm install .



mkdir data
cd data

# Tippecanoe installation
sudo apt-get install libsqlite3-dev libz-dev
git clone https://github.com/mapbox/tippecanoe.git
cd tippecanoe
make -j
sudo make install
cd ..
rm -rf tippecanoe

# pmtiles tool installation
wget https://github.com/protomaps/go-pmtiles/releases/download/v1.25.3/go-pmtiles_1.25.3_Linux_x86_64.tar.gz -O pmtiles.tar.gz
tar -zxf pmtiles.tar.gz
rm pmtiles.tar.gz README.md LICENSE

# MBtiles conversion to PMtiles
./pmtiles convert carte_fibre_immeubles_2024_t3.mbtiles carte_fibre_immeubles_2024_t3.pmtiles
