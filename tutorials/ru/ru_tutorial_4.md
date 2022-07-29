# Установка нужного программного обеспечения

## Обновление системы
```bash
sudo apt update && sudo apt upgrade -y
```

## Проверка CPU
```bash
lscpu | grep -P '(?=.*avx )(?=.*sse4.2 )(?=.*cx16 )(?=.*popcnt )' > /dev/null \
  && echo "Supported" \
  || echo "Not supported"
```

## Установка  NEAR-CLI
> Примечание. Из соображений безопасности рекомендуется установить NEAR-CLI на компьютер, отличный от вашего узла валидатора, и чтобы на вашем узле валидатора не хранились ключи полного доступа.

Вводим следующие команды по очереди:

```bash
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
```
```bash
sudo apt install build-essential nodejs
```
```bash
PATH="$PATH"
```
```bash
sudo npm install -g near-cli
```

##  Установка сети в которой будет работать наша нода
```bash
echo 'export NEAR_ENV=shardnet' >> ~/.bashrc
```

## Установка ноды
По очереди вводим следующие команды
```bash
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo
```
```bash
sudo apt install python3-pip
```
```bash
sudo apt install clang build-essential make
```

Установите конфигурацию:
```bash
USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"
```

#### установка rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Во время установки у нас спросят про варианты установки, выбираем номер 1 - proceed with installation
 
 <img width="651" alt="Снимок экрана 2022-07-20 в 23 22 47" src="https://user-images.githubusercontent.com/51726132/180079297-532a8fe1-5a25-49d6-bd33-3b59414715ad.png">
<img width="647" alt="Снимок экрана 2022-07-20 в 23 23 21" src="https://user-images.githubusercontent.com/51726132/180079098-97ffa43e-cadc-4b4c-9947-a8b56cac119e.png">

 
 <img width="500" alt="Снимок экрана 2022-07-20 в 23 24 02" src="https://user-images.githubusercontent.com/51726132/180078966-27d2cf11-c0f3-454e-83c3-c25ea94ef201.png">
 
 ```bash
source $HOME/.cargo/env
```


### Установка nearcore

```bash
git clone https://github.com/near/nearcore && cd nearcore && git fetch

```

Выбираем коммит на который нужно переключиться, переходим по ссылке и смотрим 
https://github.com/near/stakewars-iii/blob/main/commit.md

далее нужно  заменить \<commit\> на хэш который находится по ссылке

```bash
 git checkout <commit>
```

<img width="657" alt="Снимок экрана 2022-07-20 в 23 26 01" src="https://user-images.githubusercontent.com/51726132/180079819-0f050993-67fc-4bc0-8cc9-0a3769175857.png">
 
Компиляция nearcore
 
 <img width="626" alt="Снимок экрана 2022-07-20 в 23 26 17" src="https://user-images.githubusercontent.com/51726132/180079913-6d4a9d31-3c46-4439-91b0-8192e663bc39.png">

```bash
 cargo build -p neard --release --features shardnet
 ```

 ### Инициализация рабочей директории

 Эта команда создаст структуру каталогов и сгенерирует config.json, node_key.json и genesis.json в сети, через которую вы прошли. 

**config.json **— параметры конфигурации, которые реагируют на то, как будет работать узел. config.json содержит необходимую информацию для работы узла в сети, как общаться с одноранговыми узлами и как достичь консенсуса. Хотя некоторые параметры настраиваются. Обычно валидаторы предпочитают использовать предоставленный по умолчанию файл config.json.

**genesis.json** — файл со всеми данными, с которых началась сеть при генезисе. Он содержит начальные учетные записи, контракты, ключи доступа и другие записи, которые представляют начальное состояние блокчейна. Файл genesis.json представляет собой снимок состояния сети в определенный момент времени. В контактах аккаунты, балансы, активные валидаторы и прочая информация о сети.

 **node_key.json** — файл, содержащий открытый и закрытый ключи для узла. Также включает необязательный параметр account_id, необходимый для запуска узла проверки (не рассматривается в этом документе). 
 
 **data/** - Папка, в которую узел NEAR будет записывать свое состояние.


```bash
 ./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis
 ```
 
<img width="649" alt="Снимок экрана 2022-07-20 в 23 43 35" src="https://user-images.githubusercontent.com/51726132/180079992-4ddc221b-d975-4c85-825b-07c2e07403c8.png">
 
 
#### Удаляем конфиг по умолчанию и ставим рекомендуемый
 
```bash
rm ~/.near/config.json 
```

 ```bash
 wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json
```
 
 <img width="647" alt="Снимок экрана 2022-07-20 в 23 43 55" src="https://user-images.githubusercontent.com/51726132/180080142-4e2e0639-5d6c-49e9-bfae-6649888e217a.png">

## Запуск ноды 

 ```bash
cd nearcore
./target/release/neard --home ~/.near run

```
 <img width="579" alt="Снимок экрана 2022-07-20 в 23 55 29" src="https://user-images.githubusercontent.com/51726132/180080499-8b57a50b-54b6-4447-818b-63375fb616a0.png">
 
 
 Ждем пока пока не скачаются все блоки, в логах пишется процент загрузки **Downloading blocks 90.11%**
 
 
### Активация режима валидатора в ноде

 ```bash
 near login
```

 Появится ссылка по которой нужно перейти
 Ее нужно скопировать и подтвердить активацию приложения

 после того как вас переадресует на 127.0.0.1
 вводим ваш \<login\>.shardnet.near и жмем enter

 Настройка ключей validator_key.json
```bash
 near generate-key <login>.factory.shardnet.near
```
```bash
cp ~/.near-credentials/shardnet/<login>.shardnet.near.json ~/.near/validator_key.json
```
Открываем файл для редактирования 

```sh
 nano ~/.near/validator_key.json
 ```
 Изменяем “account_id” => \<login\>.factory.shardnet.near
 А так же нужно заменить private_key на secret_key

 пример
```json
 {
  "account_id": "xx.factory.shardnet.near",
  "public_key": "ed25519:HeaBJ3xLgvZacQWmEctTeUqyfSU4SDEnEwckWxd92W2G",
  "secret_key": "ed25519:****"
}
 ```

### Настройка автозапуска ноды
 Следующий код нужно вставить в **/etc/systemd/system/neard.service** и заменить $USER на текущего пользователя операционной системы(не near логин)

 $HOME заменить на путь до папки пользователя
 Можно вписать этот код в терминал и узнать расположение папки
 
 <img width="281" alt="Снимок экрана 2022-07-21 в 00 40 58" src="https://user-images.githubusercontent.com/51726132/180087150-9fb2f293-da8d-4834-85bd-d423e99b2138.png">

```
[Unit]
Description=NEARd Daemon Service
[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/.near
ExecStart=$HOME/nearcore/target/release/neard run
Restart=on-failure
RestartSec=30
KillSignal=SIGINT
TimeoutStopSec=45
KillMode=mixed

[Install]
WantedBy=multi-user.target

```
 
 ```bash
sudo nano /etc/systemd/system/neard.service
 ```
Для выходы жмем **ctrl+X** и потом жмем **Y**.  Получится как на скриншоте ниже:
 
 <img width="404" alt="Снимок экрана 2022-07-21 в 00 41 38" src="https://user-images.githubusercontent.com/51726132/180087241-61a78e8f-4561-4566-bd4b-9f60e364a967.png">

```bash
# Включаем автозапуск ноды
sudo systemctl enable neard
# Запуск ноды 
sudo systemctl start neard
# Если вам нужно внести изменение в сервис из-за ошибки в файле. Его необходимо перезагрузить:
sudo systemctl reload neard
```

### Просмотр логов

 ```bash
 journalctl -n 100 -f -u neard | ccze -A
```
### Отправка заявления на вступление в пул валидаторов
 Заявления валидатора указывает на то, что он хотел бы войти в пул валидаторов, чтобы заявление было принято, оно должно соответствовать минимальной цене места.
 
 ```bash
near proposals
```
 
### Подключение пула для стейкинга

 <public_key> - берем из /.near/validation_keys.json

 ```bash
near call factory.shardnet.near create_staking_pool '{"staking_pool_id": "<pool id>", "owner_id": "<accountId>", "stake_public_key": "<public key>", "reward_fee_fraction": {"numerator": 5, "denominator": 100}, "code_hash":"DD428g9eqLL8fWUxv8QSpVFzyHi1Qd16P8ephYCTmMSZ"}' --accountId="<accountId>" --amount=30 --gas=300000000000000

```
  
В приведенном выше примере вам нужно заменить:
  - Идентификатор пула: имя пула ставок, фабрика автоматически добавляет свое имя к этому параметру, создавая {pool_id}. {staking_pool_factory} 
    Примеры: Если id пула — stackwars, то он создаст: stackwars.factory.shardnet.near 
  - Идентификатор владельца: учетная запись SHARDNET (т. е. Stawares.shardnet.near), которая будет управлять пулом ставок. 
  - Открытый ключ: открытый ключ в вашем файле validator_key.json. 
  - 5: комиссия, которую будет взимать пул (например, в этом случае 5 больше 100 составляет 5% от комиссии). 
  - Идентификатор учетной записи: учетная запись SHARDNET, развертывающая и подписывающая mount tx. Обычно совпадает с идентификатором владельца.
 
 
 
 
 #### Установка коммисии пула

```bash
near call <pool_name> update_reward_fee_fraction '{"reward_fee_fraction": {"numerator": 1, "denominator": 100}}' --accountId <account_id> --gas=300000000000000
 ```


Для того чтобы появится в списке валидаторов нужно выполнить пинг

```bash
near call <staking_pool_id> ping '{}' --accountId <accountId> --gas=300000000000000
```


Другие команды:

Просмотр Баланса


команда:
```
near view <staking_pool_id> get_account_total_balance '{"account_id": "<accountId>"}'
```
#####  Просмотр застейканного баланса

команда:
```
near view <staking_pool_id> get_account_staked_balance '{"account_id": "<accountId>"}'
```
##### Убрать средства из стейкнигна
команда:
```
near view <staking_pool_id> get_account_unstaked_balance '{"account_id": "<accountId>"}'
```
##### Снятие средств
команда:
```
near view <staking_pool_id> is_account_unstaked_balance_available '{"account_id": "<accountId>"}'
```
##### Пауза / Возобновление Стейкинга

###### Пауза
команда:
```
near call <staking_pool_id> pause_staking '{}' --accountId <accountId>
```
###### Возобновление
команда:
```
near call <staking_pool_id> resume_staking '{}' --accountId <accountId>
```


## Мониторинг


### Оповещения

Уведомление по электронной почте может сделать работу валидатора более удобной. 

Системная команда:
```
journalctl -n 100 -f -u neard | ccze -A
```

**Пример лога:**

Validator | 1 validator

```
INFO stats: #85079829 H1GUabkB7TW2K2yhZqZ7G47gnpS7ESqicDMNyb9EE6tf Validator 73 validators 30 peers ⬇ 506.1kiB/s ⬆ 428.3kiB/s 1.20 bps 62.08 Tgas/s CPU: 23%, Mem: 7.4 GiB
```

* **Validator**:  “Validator” укажет, что вы являетесь активным валидатором.
* **73 validators**: всего 73 валидатора в сети
* **30 peers**: у вас сейчас 30 пиров. Вам нужно как минимум 3 пира, чтобы достичь консенсуса и начать проверку
* **#46199418**: block – следите за тем, чтобы блоки двигались

#### RPC
Любой узел в сети предлагает службы RPC через порт 3030, если этот порт открыт в брандмауэре. NEAR-CLI использует вызовы RPC. Обычно RPC используется для проверки статистики валидатора, версии узла и просмотра доли делегатора, хотя его можно использовать для взаимодействия с блокчейном, учетными записями и контрактами в целом.


https://docs.near.org/docs/api/rpc



Command:
```
sudo apt install curl jq
```
###### Общие команды:
####### Проверьте версию вашего узла:
Команда:
```
curl -s http://127.0.0.1:3030/status | jq .version
```
####### Проверка Delegators и Stake
команда:
```
near view <your pool>.factory.shardnet.near get_accounts '{"from_index": 0, "limit": 10}' --accountId <accountId>.shardnet.near
```
####### Проверить причину выхода валидатора из пула вадидаторов
команда:
```
curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' 127.0.0.1:3030 | jq -c '.result.prev_epoch_kickout[] | select(.account_id | contains ("<POOL_ID>"))' | jq .reason
```
####### Проверка созданных/ожидаемых блоков
команда:
```
curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' 127.0.0.1:3030 | jq -c '.result.current_validators[] | select(.account_id | contains ("POOL_ID"))'
```


