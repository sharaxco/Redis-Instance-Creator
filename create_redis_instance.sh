#!/bin/bash

# This script is part of the redis-instance-creator project: https://github.com/sharaxco/redis-instance-creator

# Check if the right number of arguments are provided
if [ "$#" -ne 4 ]; then
    echo "Usage: ./create_redis_instance.sh <name> <dir> <port> <password>"
    exit 1
fi

# Assign variables from arguments
name=$1
dir=$2
port=$3
password=$4

# Create the instance directory if it doesn't exist
echo "Creating instance directory..."
mkdir -p $dir/$name
sleep 1

# Create a configuration file for this instance
echo "Creating configuration file..."
echo "port $port
requirepass $password
daemonize no
dir $dir/$name
loadmodule /opt/redis-stack/lib/redisearch.so
loadmodule /opt/redis-stack/lib/redisgraph.so
loadmodule /opt/redis-stack/lib/redistimeseries.so
loadmodule /opt/redis-stack/lib/rejson.so
loadmodule /opt/redis-stack/lib/redisbloom.so" > /etc/redis-$name.conf
sleep 1

# Create a systemd service file for this instance
echo "Creating systemd service file..."
echo "[Unit]
Description=Redis stack server: $name
Documentation=https://redis.io/
After=network.target

[Service]
Type=simple
User=nobody
ExecStart=/opt/redis-stack/bin/redis-server /etc/redis-$name.conf
WorkingDirectory=$dir/$name
UMask=0077

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/redis-stack-$name.service
sleep 1

# Reload the systemd daemon to recognize the new service
echo "Reloading systemd daemon..."
systemctl daemon-reload
sleep 1

# Enable the service to start at boot
echo "Enabling service to start at boot..."
systemctl enable redis-stack-$name.service
sleep 1

# Start the new Redis instance
echo "Starting new Redis instance..."
systemctl start redis-stack-$name.service
sleep 1

echo "Redis instance $name has been created and started!"
