FROM jupyterhub/jupyterhub

RUN apt update && apt install python3

COPY ./requirements.txt .
RUN pip install -r ./requirements.txt

EXPOSE 8000

# -m, --create-home
# Create the user's home directory if it does not exist
# -d, --home HOME_DIR
# The new user will be created using HOME_DIR as the value for the user's login directory
RUN useradd -m -d /home/admin admin
COPY config.py .

ARG NOTEBOOKS_FROM=./empty_folder
ARG HUB_PATH=/home/admin/preexisting_notebooks
COPY ${NOTEBOOKS_FROM} ${HUB_PATH}

CMD [ "jupyterhub", "-f", "config.py"]
