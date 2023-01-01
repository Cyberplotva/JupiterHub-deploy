# Берём за основу оффициальный образ от Jupyter
FROM jupyterhub/jupyterhub

# Скачивание питона
RUN apt update && apt install python3

# Установка необходиммых питоновских библиотек
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt

# Какой порт будет открыт у контейнера
EXPOSE 8000

# Создать в ос нового пользователя, сделать ему домашнюю директорию
RUN useradd -m -d /home/admin admin

# Откуда и куда копировать файлы. Пермененные - аргументы из docker-compose build --build-arg ...
ARG NOTEBOOKS_FROM=./empty_folder
ARG HUB_PATH=/home/admin
COPY ${NOTEBOOKS_FROM} ${HUB_PATH}

# Запустить Jupyter Hub, использую confing.py
COPY config.py .
CMD [ "jupyterhub", "-f", "config.py"]
