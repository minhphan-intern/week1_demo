#!/bin/bash

db_name="bookstore"
table_name="book"
user="pm"
hba_path="/etc/postgresql/15/main/pg_hba.conf"
postgres_conf_path="/etc/postgresql/15/main/postgresql.conf"
user_subnet="host    all             all             192.168.22.10/24        md5"
server_IP="'192.168.22.11'"

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo -u postgres psql -c "DROP USER IF EXISTS $user;"
sudo -u postgres psql -c "CREATE USER $user WITH PASSWORD 'pm';"
sudo -u postgres psql -c "DROP DATABASE IF EXISTS $db_name;"
sudo -u postgres psql -c "CREATE DATABASE bookstore WITH OWNER = $user;"
sudo -u postgres psql -d bookstore -c "DROP TABLE IF EXISTS $table_name;"
sudo -u postgres psql -d bookstore -c "CREATE TABLE $table_name (
isbn VARCHAR(255) PRIMARY KEY,
name VARCHAR(255) NOT NULL,
num_of_page INT,
authors VARCHAR NOT NULL,
published_year INT,
cover_url VARCHAR,
sell_price INT
);"
sudo -u postgres psql -d $db_name -c "COPY $table_name FROM '/vagrant_data/data/db/data.csv' WITH (FORMAT csv);"
sudo -u postgres psql -d $db_name -c "ALTER TABLE $table_name OWNER TO pm;"
sudo sed -i "98i\\$user_subnet" $hba_path
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = $server_IP/" $postgres_conf_path
sudo systemctl restart postgresql