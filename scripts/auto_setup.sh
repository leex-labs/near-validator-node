echo -e """
    __ __             __  __ 
|  |_ |_ \_/  |   /\ |__)(_  
|__|__|__/ \  |__/--\|__)__) 

\033[;32mSetup Near Validator Node \033[0m\n
"""
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
# Проверка CPU
if lscpu | grep -P -q '(?=.*avx )(?=.*sse4.2 )(?=.*cx16 )(?=.*popcnt )'
   then
      echo ""
   else
      echo -e "\e[31mInstallation is not possible, your server does not support AVX, change your server and try again.\e[39m"
      exit
fi

if [ ! $NEAR_USERNAME ]; then
read -p "Enter username without .shardnet.near (example if you have login.shardnet.near you have to write login): " NEAR_USERNAME
echo 'export NEAR_USERNAME='\"${NEAR_USERNAME}\" >> $HOME/.bash_profile
fi
#  Установка сети в которой будет работать наша нода
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
echo 'export NEAR_ENV=shardnet' >> ~/.bash_profile
echo "export WORKSPACE=\"$HOME/nearcore\"" >>$HOME/.bash_profile
. $HOME/.bash_profile


# Обновление системы
sudo apt update && sudo apt upgrade -y
# Установка  NEAR-CLI
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs
PATH="$PATH"
# NEAR-CLI
node -v
# v18.x.x
npm -v
# 8.x.x

sudo npm install -g near-cli

# Установка ноды
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo build-essential make ccze python3-pip

USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"

sudo apt install -y clang build-essential make

# установка rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# во время установки у нас спросят про варианты установки
# выбираем номер 1 - proceed with installation
source $HOME/.cargo/env

# Установка nearcore
git clone https://github.com/near/nearcore
cd nearcore
git fetch

# Выбираем коммит на который нужно переключиться, переходим по ссылке и смотрим https://github.com/near/stakewars-iii/blob/main/challenges/commit.md
# нужно далее заменить <commit> на нужный хэш который находится по ссылке
git checkout $(curl https://raw.githubusercontent.com/near/stakewars-iii/main/challenges/commit.md)

# Компиляция nearcore
cargo build -p neard --release --features shardnet

# Инициализация рабочей директории
./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis

# Удаляем конфиг по умолчанию и ставим рекомендуемый
rm ~/.near/config.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json

# Запуск ноды 
./target/release/neard --home ~/.near run


# Активация режима валидатора в ноде
echo """
#       #######  #####  ### #     # 
#       #     # #     #  #  ##    # 
#       #     # #        #  # #   # 
#       #     # #  ####  #  #  #  # 
#       #     # #     #  #  #   # # 
#       #     # #     #  #  #    ## 
####### #######  #####  ### #     # 
"""
near login

# Появится ссылка по которой нужно перейти
# Ее нужно скопировать и подтвердить активацию приложения

# после того как вас переадресует на 127.0.0.1
# вводим ваш <login>.shardnet.near и жмем enter

# Настройка ключей validator_key.json
near generate-key "$NEAR_USERNAME.factory.shardnet.near"
cp ~/.near-credentials/shardnet/$NEAR_USERNAME.factory.shardnet.near.json ~/.near/validator_key.json
# fix validator_key names
wget -q -O validator_keys_fix.py https://raw.githubusercontent.com/leex-labs/near-validator-node/main/scripts/validator_keys_fix.py && chmod +x validator_keys_fix.py && python3 validator_keys_fix.py

# Настройка автозапуска ноды
echo """
[Unit]
Description=NEARd Daemon Service
[Service]
Type=simple
User=\"$USER\"
WorkingDirectory=\"$HOME\"/.near
ExecStart=\"$HOME\"/nearcore/target/release/neard run
Restart=on-failure
RestartSec=30
KillSignal=SIGINT
TimeoutStopSec=45
KillMode=mixed

[Install]
WantedBy=multi-user.target
""" > /etc/systemd/system/neard.service


# Включаем автозапуск ноды
sudo systemctl enable neard
# Запуск ноды 
sudo systemctl start neard
# Если вам нужно внести изменение в сервис из-за ошибки в файле. Его необходимо перезагрузить:
sudo systemctl reload neard

