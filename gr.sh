#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}

service_exists() {
    local n=$1
    if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
        return 0
    else
        return 1
    fi
}

if exists curl; then
	echo ''
else
  sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
function setupVars {
if [ ! $NODENAME_GEAR ]; then
		read -p "Enter node Name: " NODENAME_GEAR
	fi
echo 'Your node Name: ' $NODENAME_GEAR
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile

	sleep 1
}



function installDeps {
	echo -e '\n\e[42mPreparing to install\e[0m\n' && sleep 1
	cd $HOME
	sudo apt update
  sudo apt install curl make clang pkg-config libssl-dev build-essential git mc jq unzip wget -y < "/dev/null"
	sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
	source $HOME/.cargo/env
  sleep 1
	sudo apt install --fix-broken -y &>/dev/null
  sudo apt install nano mc git mc clang curl jq htop net-tools libssl-dev llvm libudev-dev -y &>/dev/null
  source $HOME/.profile &>/dev/null
  source $HOME/.bashrc &>/dev/null
  source $HOME/.cargo/env &>/dev/null
  sleep 1
}

function installSoftware {
  echo -e '\n\e[42mInstall node\e[0m\n' && sleep 1
	wget https://get.gear.rs/gear-nightly-x86_64-unknown-linux-gnu.tar.xz &>/dev/null
  	tar xvf gear-nightly-x86_64-unknown-linux-gnu.tar.xz &>/dev/null
  	rm gear-nightly-x86_64-unknown-linux-gnu.tar.xz
  	chmod +x $HOME/gear &>/dev/null
}
function backup {
	if [ ! -d $HOME/gearbackup/ ]; then
  		mkdir $HOME/gearbackup
	 fi
	 #создаем бекап
	 last=$(ls -tr1 $HOME/.local/share/gear/chains | tail -1)
	 if [  -d $HOME/.local/share/gear/chains/$last ]; then
		cp $HOME/.local/share/gear/chains/$last/network/secret_ed25519 $HOME/gearbackup/secret_ed25519 
	 fi
	 echo -e "BackUp ready \e[39m!"
	}
function restore {
	sleep 45
	last=$(ls -tr1 $HOME/.local/share/gear/chains | tail -1)
	backup=$(ls -tr1 $HOME/gearbackup/ | tail -1)
	if [ -d $HOME/.local/share/gear/chains/$last ]; then
	cp $HOME/gearbackup/$backup $HOME/.local/share/gear/chains/$last/network/secret_ed25519
	fi
	sudo systemctl restart gear
	
  }
function cleardb { 
	sudo systemctl stop gear 
	/root/gear purge-chain -y
	sudo systemctl start gear
}
function updateSoftware {
	sudo systemctl stop gear
	sleep 2
	wget https://get.gear.rs/gear-nightly-x86_64-unknown-linux-gnu.tar.xz &>/dev/null
  	tar xvf gear-nightly-x86_64-unknown-linux-gnu.tar.xz &>/dev/null
  	rm gear-nightly-x86_64-unknown-linux-gnu.tar.xz
  	chmod +x $HOME/gear &>/dev/null
	sleep 2
	sudo systemctl restart gear
	 . $HOME/.bash_profile
}
function logs {
		journalctl -n 100 -f -u gear
}

function installService {
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald

sudo tee <<EOF >/dev/null /etc/systemd/system/gear.service
[Unit]
Description=Gear Node
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=/root/gear \
        --name $NODENAME_GEAR \
        --execution wasm \
	--port 31333 \
	--no-private-ipv4 \
        --telemetry-url 'ws://telemetry-backend-shard.gear-tech.io:32001/submit 0' \
	--telemetry-url 'wss://telemetry.postcapitalist.io/submit 0'
Restart=always
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl restart systemd-journald &>/dev/null
sudo systemctl daemon-reload &>/dev/null
sudo systemctl enable gear &>/dev/null
sudo systemctl restart gear &>/dev/null

}

function deletegear {
		systemctl stop gear
		systemctl disable gear
		rm $HOME/gear
		rm -rf $HOME/.local/share/gear/
}


PS3='Please enter your choice (input your option number and press enter): '
options=("Install" "Log" "Clear_db" "Update" "Upgrade" "Delete" "Quit")
#options=("Install" "Log" "Clear_db" "Update" "Delete" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install")
 		echo -e '\n\e[42mYou choose install...\e[0m\n' && sleep 1
			setupVars
			installDeps
			installSoftware
			installService 
			echo -e '\n\e[33mNode install!\e[0m\n' && sleep 1
			restore
			echo -e "Check logs: \e[35m journalctl -n 100 -f -u gear\e[0m\n"
			break
            ;;
		"Update")
            echo -e '\n\e[33mYou choose update...\e[0m\n' && sleep 1
	    		backup
			updateSoftware
			echo -e '\n\e[33mYour node was update!\e[0m\n' && sleep 1
			break
            ;;
	    "Upgrade")
            echo -e '\n\e[33mYou choose upgrade...\e[0m\n' && sleep 1
			backup
			cleardb
			updateSoftware
			restore
			echo -e '\n\e[33mYour node was upgraded!\e[0m\n' && sleep 1
			break
            ;;
	    "Clear_db")
	    echo -e '\n\e[33mYou choose clear db...\e[0m\n' && sleep 1
			cleardb
			echo -e '\n\e[34mData Base removed!\e[0m\n' && sleep 1
	    		break
	    ;;
		 "Log")
	    echo -e '\n\e[33mYou choose Log\e[0m\n' && sleep 1
			logs
		 		break
				;;
	    "Delete")
            echo -e '\n\e[31mYou choose delete...\e[0m\n' && sleep 1
			backup
			deletegear
			echo -e '\n\e[42mGear was deleted!\e[0m\n' && sleep 1
			break
            ;;
        "Quit")
            break
            ;;
        *) echo -e "\e[91minvalid option $REPLY\e[0m";;
    esac
done