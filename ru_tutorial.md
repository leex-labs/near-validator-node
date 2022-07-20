# Как установить ноду валидации в сети NEAR
В данном примере рассмотрим разворачивание ноды в сети **shardnet**
[[TOC]]

## Шаг 1. Создание кошелька 
1. Переходим по ссылке https://wallet.shardnet.near.org/ 

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179840883-d6b770c1-b2a3-48f6-bcfa-7cf0e936ab92.png">

2. Нажимаем создать учетную запись

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179840955-752bd485-0ebe-433e-a692-04f6ce7c2090.png">

3. Придумываем и вводим ваш логин в сети shardnet

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179841026-359146fe-5565-4e13-8583-872b6b968938.png">

4. Выбираем предпочтительный способ защиты кошелька.Рекомендуется выбирать либо мнемоническую фразу, либо если у вас есть аппаратный криптокошелек ledger его

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179841912-9e610304-e020-4dd4-a9f1-0a343d4227f6.png">

Сохраняем мнемофразу, туда откуда ее не смогут украсть и где вы ее не потеряете 

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179841643-20e501db-26a3-4676-ac47-4e1982f998c8.png">

5. Выполяем проверку что вы верно запомнили мнемофразу

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179841694-e87754b3-ee6c-4eaf-a841-901cd6de339d.png">

6. Далее, для входа в аккаунт вводим сохраненную мнемофразу

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179842212-8af4208c-7796-4300-afa0-c40ed787fd6e.png">

Поздравляю вы вошли в ваш криптокошелек, на балансе в данной сети будут деньги для тестирования вашей ноды

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179842316-c5c878b7-6073-4ce2-96af-ba5a298598e4.png">

## Создание сервера на DigitalOcean
1. Регистрируемся в DigitalOcean
2. Переходим во вкладку Droplets для создания вашего сервера
3. Выбираем create Droplet


<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858007-27cbba84-40c2-4cab-8e51-f23761943ea7.png">
4. Выбираем операционную систему, в нашем случае Ubuntu 22.04
5. Выбираем тариф с достаточным кол-вом памяти 600GB SSD (рекомендуется 500, но мы взяли с запасом)

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858100-582e7bde-85da-433d-97ce-26c522426da9.png">
6. Выбираем регион расположения дата центра, можно выбрать тот который расположен в европе, серверной америке и тд. Рекомендую выбирать тот который расположен в европе, так как мы знаем что американцы не очень хорошо относятся к криптовалютам и вероятно тут будет меньше клиентов

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858113-76a9ecc4-59ae-4eb8-bc80-291166948964.png">
7. Добавляем способо авторизации. Рекомендуется ssh keys так как это более надежный и безопасный способ. Но для начала можно выбрать авторизацию по паролю и позже подключить рекомендуемую.
Так же рекомундую поставить мониторинг для отслеживания показателей сервера. Но для этого придется поставить еще один скрипт для установки агента, отслеживающего показатели (рассмотрим далее)

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858251-ea6cadc1-3325-425d-a46b-3e8551639f45.png">

8. Мы подошли к финальному шагу, теперь жмем create droplet.

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858267-84aef735-ca11-4dcd-8772-76ebb2e05c04.png">

9. Ждем пару минут и сервер создастся.

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858304-b86fc71c-b68e-4019-a224-75b860f2efdb.png">
10. После создания сервер копируем **ip адрес** сервера

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858364-96f74165-06ba-4a54-ba6a-9d0a1d44a155.png">
<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858421-fcd03f55-3da5-4d49-8d38-66d5d740a5b0.png">

скрипт для установки мониторинга на сервере

```bash
wget -qO- https://repos-droplet.digitalocean.com/install.sh | sudo bash
```

## Базовая настройка сервера
 ### Шаг 1 — Вход с привилегиями root
 
 <img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858542-0d12b4e3-2846-4865-8628-17768b871750.png">
 
Чтобы войти на сервер, вам нужно знать публичный IP-адрес вашего сервера. Также вам потребуется пароль или, если вы установили ключ SSH для аутентификации, приватный ключ для учетной записи root user. Если вы еще не выполнили вход на сервер, вы можете воспользоваться нашей документацией по подключению к вашему Droplet с помощью SSH, которая подробно описывает этот процесс.

Если вы еще не подключились к серверу, выполните вход в систему как root user, используя следующую команду (замените выделенную часть команды на публичный IP-адрес вашего сервера):

```bash
ssh root@your_server_ip
```

Примите предупреждение об аутентичности хоста, если оно появится на экране. Если вы используете аутентификацию по паролю, укажите пароль root для входа в систему. Если вы используете ключ SSH с защитой по фразе-паролю, вам может быть предложено ввести фразу-пароль в первый раз при использовании ключа в каждом сеансе. Если вы первый раз выполняете вход на сервер с помощью пароля, вам также может быть предложено изменить пароль root.

<img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179858585-7a53bdbd-ed4c-4bfa-be47-15fe7cff5ebe.png">

#### Подробнее о root
root user — это пользователь с правами администратора в среде Linux, который имеет очень широкий набор привилегий. Из-за такого широкого набора привилегий учетной записи root не рекомендуется использовать ее на регулярной основе. Это связано с тем, что часть возможностей, получаемых с помощью учетной записи root, включает возможность внесения очень разрушительных изменений, даже если это происходит непреднамеренно.

В следующем шаге будет настраиваться новая учетная запись пользователя с ограниченными привилегиями для повседневного использования. Позже мы расскажем о том, как получить расширенные привилегии только на то время, когда они необходимы.

### Шаг 2 — Создание нового пользователя
<img width="462" alt="image" src="https://user-images.githubusercontent.com/51726132/179859012-f26bdda4-0c9e-4837-84d5-882363a3ea23.png">
<
После входа в систему с правами root мы готовы добавить новую учетную запись пользователя. В будущем мы выполним вход с помощью этой новой учетной записи, а не с правами root.

Этот пример создает нового пользователя с именем andrew, но вы должны заменить это имя на имя, которое вам нравится:
```bash
adduser andrew
```
Вам будет предложено ответить на несколько вопросов, начиная с пароля учетной записи.

Введите надежный пароль и введите по желанию любую дополнительную информацию. Это делать необязательно, и вы можете нажать **ENTER** в любом поле, которое вы хотите пропустить.

### Шаг 3 — Предоставление административных прав
<img width="451" alt="image" src="https://user-images.githubusercontent.com/51726132/179859041-d66e7be3-ffbe-473b-9625-10272bd8ff25.png">

Теперь у нас есть новая учетная запись пользователя со стандартными правами. Однако иногда может потребоваться выполнение административных задач.

Чтобы не выполнять выход из стандартной учетной записи и выполнять вход в систему с учетной записью root, мы можем настроить так называемого суперпользователя или добавить привилегии root для стандартной учетной записи. Это позволит нашему обычному пользователю запускать команды с правами администратора, указав слово sudo перед каждой командой.

Чтобы добавить эти права для нового пользователя, нам нужно добавить пользователя в группу sudo. По умолчанию в Ubuntu 20.04 пользователи, входящие в группу sudo могут использовать команду sudo.

Используя права root, запустите эту команду, чтобы добавить нового пользователя в группу sudo (замените выделенное имя пользователя на нового пользователя):
```bash
usermod -aG sudo andrew
```

Для смены аккаунта можно воспользоваться следующей командой 
```
sudo su - andrew
```
andrew - заменить на ваш логин, который вы придумали на шаге выше

 <img width="500" alt="image" src="https://user-images.githubusercontent.com/51726132/179859072-4955f06f-0279-4ac9-9792-85566e995a41.png">
 
Теперь, когда вы войдете в систему со стандартным пользователем, вы можете ввести sudo перед командами для выполнения действий с правами суперпользователя.

## Установка нужного программного обеспечения
#### Обновление системы
```
sudo apt update && sudo apt upgrade -y
```
#### Проверка CPU
```
lscpu | grep -P '(?=.*avx )(?=.*sse4.2 )(?=.*cx16 )(?=.*popcnt )' > /dev/null \
  && echo "Supported" \
  || echo "Not supported"
```
#### Установка  NEAR-CLI
```
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs
PATH="$PATH"
# NEAR-CLI
node -v
# v18.x.x
npm -v
# 8.x.x
sudo npm install -g near-cli
```

####  Установка сети в которой будет работать наша нода
```
echo 'export NEAR_ENV=shardnet' >> ~/.bashrc
```
#### Установка ноды
```
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo build-essential make ccze
sudo apt install python3-pip

USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"
```
#### установка rust

<img width="651" alt="Снимок экрана 2022-07-20 в 23 22 47" src="https://user-images.githubusercontent.com/51726132/180079297-532a8fe1-5a25-49d6-bd33-3b59414715ad.png">

<img width="647" alt="Снимок экрана 2022-07-20 в 23 23 21" src="https://user-images.githubusercontent.com/51726132/180079098-97ffa43e-cadc-4b4c-9947-a8b56cac119e.png">

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
 Во время установки у нас спросят про варианты установки
 
 выбираем номер 1 - proceed with installation
 
 <img width="500" alt="Снимок экрана 2022-07-20 в 23 24 02" src="https://user-images.githubusercontent.com/51726132/180078966-27d2cf11-c0f3-454e-83c3-c25ea94ef201.png">
 
 ```
source $HOME/.cargo/env
```

#### Установка nearcore
```
git clone https://github.com/near/nearcore && cd nearcore && git fetch
```

Выбираем коммит на который нужно переключиться, переходим по ссылке и смотрим 
https://github.com/near/stakewars-iii/blob/main/commit.md

нужно далее заменить <commit> на нужный хэш который находится по ссылке
 
```bash
 git checkout <commit>
```

<img width="657" alt="Снимок экрана 2022-07-20 в 23 26 01" src="https://user-images.githubusercontent.com/51726132/180079819-0f050993-67fc-4bc0-8cc9-0a3769175857.png">
 
Компиляция nearcore
 
 <img width="626" alt="Снимок экрана 2022-07-20 в 23 26 17" src="https://user-images.githubusercontent.com/51726132/180079913-6d4a9d31-3c46-4439-91b0-8192e663bc39.png">

```
 cargo build -p neard --release --features shardnet
 ```

 Инициализация рабочей директории
```
 ./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis
 ```
<img width="649" alt="Снимок экрана 2022-07-20 в 23 43 35" src="https://user-images.githubusercontent.com/51726132/180079992-4ddc221b-d975-4c85-825b-07c2e07403c8.png">
 
 
Удаляем конфиг по умолчанию и ставим рекомендуемый
 
```
rm ~/.near/config.json 
```

 ```
 wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json
```
 
 <img width="647" alt="Снимок экрана 2022-07-20 в 23 43 55" src="https://user-images.githubusercontent.com/51726132/180080142-4e2e0639-5d6c-49e9-bfae-6649888e217a.png">

#### Запуск ноды 

 ```
cd nearcore
./target/release/neard --home ~/.near run
```
 <img width="579" alt="Снимок экрана 2022-07-20 в 23 55 29" src="https://user-images.githubusercontent.com/51726132/180080499-8b57a50b-54b6-4447-818b-63375fb616a0.png">
 
 Ждем пока пока не скачаются все блоки, в логах пишется процент загрузки **Downloading blocks 90.11%**
 
 
### Активация режима валидатора в ноде
 ```
near login
```
 Появится ссылка по которой нужно перейти
 Ее нужно скопировать и подтвердить активацию приложения

 после того как вас переадресует на 127.0.0.1
 вводим ваш <login>.shardnet.near и жмем enter

 Настройка ключей validator_key.json
```
 near generate-key <login>.factory.shardnet.near

cp ~/.near-credentials/shardnet/<login>.shardnet.near.json ~/.near/validator_key.json
```
 
Открываем файл для редактирования 
```sh
 nano ~/.near/validator_key.json
 ```
 Изменяем “account_id” => <login>.factory.shardnet.near
 Change private_key to secret_key

 пример
```python
 {
  "account_id": "xx.factory.shardnet.near",
  "public_key": "ed25519:HeaBJ3xLgvZacQWmEctTeUqyfSU4SDEnEwckWxd92W2G",
  "secret_key": "ed25519:****"
}
 ```

### Настройка автозапуска ноды
```
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

```
 
```
# Включаем автозапуск ноды
sudo systemctl enable neard
# Запуск ноды 
sudo systemctl start neard
# Если вам нужно внести изменение в сервис из-за ошибки в файле. Его необходимо перезагрузить:
sudo systemctl reload neard
```
#### Просмотр логов
 ```
journalctl -n 100 -f -u neard | ccze -A
```
#### Отправка заявления на вступление в пул валидаторов
 Заявления валидатора указывает на то, что он хотел бы войти в пул валидаторов, чтобы заявление было принято, оно должно соответствовать минимальной цене места.
 ```
near proposals
```
 
#### Подключение пула для стейкинга
 ```
near call factory.shardnet.near create_staking_pool '{"staking_pool_id": "leex", "owner_id": "leex.shardnet.near", "stake_public_key": "ed25519:9EZCefnc1NGoGVABWuqkqX9sX6UWU92NWAujynR51u1N", "reward_fee_fraction": {"numerator": 5, "denominator": 100}, "code_hash":"DD428g9eqLL8fWUxv8QSpVFzyHi1Qd16P8ephYCTmMSZ"}' --accountId="leex.shardnet.near" --amount=30 --gas=300000000000000
```
 
#### Установка коммисии пула
```
 near call leex.factory.shardnet.near update_reward_fee_fraction '{"reward_fee_fraction": {"numerator": 1, "denominator": 100}}' --accountId leex.shardnet.near --gas=300000000000000
```
