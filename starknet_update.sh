#!/bin/bash

cd ~/pathfinder

rustup update
git fetch
git checkout v0.4.4
cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
cd py
source .venv/bin/activate
#PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
PIP_REQUIRE_VIRTUALENV=true pip install -e .[dev]
pip install --upgrade pip
#cargo run --release --bin pathfinder -- --ethereum.url https://eth-goerli.g.alchemy.com/v2/q9yNqjRYcOxA1X8EUIZJfhD2Rkm-dR-R
systemctl restart starknetd
echo -e '\n\e[42m Starknet was successfully updated \e[0m\n' && sleep 1
pathfinder -V
sklg