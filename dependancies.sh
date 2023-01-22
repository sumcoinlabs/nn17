#!/bin/bash
set -e
trap 'echo "Error Occured, Exiting..."' ERR

echo "Creating 2GB swap file..."
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Swap file created successfully!"

echo "Updating package lists..."
sudo apt-get update
echo "Package lists updated successfully!"

echo "Installing dependencies..."
sudo apt-get install -y git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev software-properties-common
echo "Dependencies installed successfully!"

echo "Adding bitcoin repository..."
echo "ppa:bitcoin/bitcoin" | sudo add-apt-repository -y
echo "Bitcoin repository added successfully!"

echo "Updating package lists..."
sudo apt-get update
echo "Package lists updated successfully!"

echo "Installing additional dependencies..."
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqt4-dev
echo "Additional dependencies installed successfully!"

echo "Cloning repository..."
git clone -b 0.17 https://github.com/sumcoinlabs/nn17.git
echo "Repository cloned successfully!"

echo "Building the software..."
cd nn17
./autogen.sh
./configure --disable-tests --disable-bench
make
echo "Software built successfully!"

trap - ERR
echo "Script executed successfully!"
