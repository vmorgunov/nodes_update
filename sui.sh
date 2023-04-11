#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

function update {
    systemctl stop suid
    rm -rf /var/sui/db/* /var/sui/genesis.blob $HOME/sui
    source $HOME/.cargo/env
    cd $HOME
    git clone https://github.com/MystenLabs/sui.git
    cd sui
    # git remote add upstream https://github.com/MystenLabs/sui
    # git fetch upstream
    # git checkout -B devnet --track upstream/devnet
    git checkout devnet-0.31.0
    # cargo build -p sui-node -p sui --release
    cargo build --bin sui-node --bin sui --release
    mv ~/sui/target/release/sui-node /usr/local/bin/
    mv ~/sui/target/release/sui /usr/local/bin/
    wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
    systemctl restart suid  
}

function reload {
    systemctl stop suid
    rm -rf /var/sui/db/*
    wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
    systemctl restart suid
}

function clearDb {
    systemctl stop suid
    sudo rm -rf /var/sui/db
    systemctl restart suid
}

function delete {
    sudo systemctl stop suid
    sudo systemctl disable suid
    rm -rf ~/sui /var/sui/
    rm /etc/systemd/suid.service
}


PS3='Please enter your choice (input your option number and press enter): '
options=("Update" "clearDb" "Reload" "Delete" "Quit")
select opt in "${options[@]}"
do
    case $opt in
		"Update")
            echo -e '\n\e[33mYou choose update...\e[0m\n' && sleep 1
			update
			echo -e '\n\e[33mYour node was updated!\e[0m\n' && sleep 1
            sui -V
			break
            ;;
	    "clearDb")
            echo -e '\n\e[33mYou choose clear Database...\e[0m\n' && sleep 1
			clearDb
			echo -e '\n\e[33mYour database was cleared!\e[0m\n' && sleep 1
			break
            ;;
		 "Reload")
            echo -e '\n\e[33mYou choose reload Database...\e[0m\n' && sleep 1
			reload
			echo -e '\n\e[33mYour database was reloaded!\e[0m\n' && sleep 1
			break
            ;;
	    "Delete")
            echo -e '\n\e[31mYou choose delete...\e[0m\n' && sleep 1
			delete
			echo -e '\n\e[42mSui was deleted!\e[0m\n' && sleep 1
			break
            ;;
        "Quit")
            break
            ;;
        *) echo -e "\e[91minvalid option $REPLY\e[0m";;
    esac
done