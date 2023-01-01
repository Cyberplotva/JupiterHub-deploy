# JupiterHub-deploy

## Цели проекта

Развёртывание экземпляр Jupiter Hub с дополнительными условиями [*(задание)*](https://github.com/ilya2108/HSE-Lab-Docker)

## Фичи

- Используется docker
  - Jupiter Hub развернут на порту 80
  - Для постоянного хранения данных из */home* используется *volume*-ы (тома, но так никто не говорит)
  - Используется docker-compose для упрощения работы с *volume*-ами и для более простого запуска 

- Реализована аутентификация
  - Используется *Dummy Authentication*
  - Добавлен только один пользователь: *admin-admin*

- При сборке образа можно устанавливать более тонкие опции
  - *NOTEBOOKS_FROM* - откуда из хоста копировать файлы (по идее в этой папке лежать ноутбуки) 
  - *HUB_PATH* - куда в контейнере копировать эти файлы


## Инструкция по развёртыванию

- Где всё развёртыется относительно хоста: 127.0.0.1:80
  - Порт можно отдельно не прописывать, так как 80 - по умолчанию
  
- В системе существует только один пользователь *admin* с паролем *admin*

- Если значения по умолчанию аргументов удовлетворяют (*NOTEBOOKS_FROM=./empty_folder HUB_PATH=/home/admin*), то: `docker-compose up`
  - При этом происходит сборка образа, создание контейнера и volum-а и запуск контейнера
  - Советую добавить флаг `-d`, чтобы логи не мучали

- Если значения по умолчанию аргументов не удовлетворяют, то
  - Для сборки образа: `docker-compose build --build-arg NOTEBOOKS_FROM=path/to/notebooks/from --build-arg HUB_PATH=path/to/notebooks/to`
    - Ни один из аргументов не обязателен, то есть эти аргументы будут принимать свои значения по умолчанию, если их явно не объявить
    - Никакие кавычки нигде не нужны, просто `... --build-arg VAR_NAME=var_value`
  - Для создания контейнера и voluma-а: `docker-compose create`

- Для запуска контейнера: `docker-compose start`

- Остановить контейнер: `docker-compose stop`

- Удалить контейнер: `docker-compose down`

## Процесс создания

- Начал писать *Dockerfile*
- Для запуска *Jupyter Hub* нужен питон
- Питона в *jupyterhub/jupyterhub* нет (просто гении)
- Сделал скачивание питона в *Dockerfile*
- Сделал скачивание нужных библиотек через *requirements.txt*
- Без аутентификация не войти (вау)
- Сделал *Dummy Authentication*
  - Возможно, в конфиге есть избыточные строки, но оно так работает отлично
- Оказывается, надо ещё пользователя в системе создать для аутентификация его в Jupyter Hub
- Добавил создание пользователя admin в *Dockerfile*
  - Создал домашнюю директорию для *admin*-а, так без этого не работает
- Обернул всё в docker-compose.yml для более простого запуска
  - Прописал порты
- Использовал volume-ы для хранения данных
  - Так проще и безопаснее, чем маунтить какую-либо директорию из хоста
- Для доп задания нашёл решение через переменные окружения
  - Мне позазалось, что прописывать переенные в *.env* файле - не совсем то, что требуется. A d одну строчку у меня (на винде) никак не pfhf,jnfkj
- Решил просто передавать аргументы через docker-compose напрямую в Dockerfile (через флаг *--build-arg*)
- Добавил нужные переменные, их дефолтные значения и копирование файлов в Doсkerfile
  - Была проблем *"как ничего не делать, когда пользователь не вводит аргументов?"*. Лучшее решение от меня: дефолтное значения места, из которого копировать - пустая папка (*.gitkeep* не считается) 
- Добавил файлы для удобной проверки работы аргументов: папка *notebooks* с *test-notebook.ipynb*
- Появилась проблема с правами доступа
  - Файлы, которые мы копируем из хоста, нельзя изменить и **сохранить**, также нельзя создавать новые файлы в этой директории
  - Оказалось, достаточно для папки *HUB_PATH* изменить права
  - Я пошёл наиболее легким путём и просто дал все права для этой папки (`chmod 777 HUB_PATH`)
  - Добавил эту команду в *Dockerfile*