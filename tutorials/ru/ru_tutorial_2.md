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

скрипт для установки мониторинга на сервере, можно будет ввести при первом запуске

```bash
wget -qO- https://repos-droplet.digitalocean.com/install.sh | sudo bash
```

