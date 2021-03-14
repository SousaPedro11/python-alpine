FROM python:alpine

LABEL maintainer="Pedro Sousa <ppls2106@gmail.com>"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN rm -rf /var/cache/apk/* && \
    apk update && \
    apk add make && \
    apk add build-base && \
    apk add gcc && \
    apk add libffi-dev && \
    apk add musl-dev && \
    apk add openssl-dev && \
    apk add git && \
    apk add zsh git-zsh-completion && \
    apk del build-base && \
    apk add python3-dev && \
    apk add postgresql-dev && \
    rm -rf /var/cache/apk/*

RUN pip install --no-cache-dir --upgrade pip

RUN pip install --no-cache-dir autopep8 flake8

RUN pip install --no-cache-dir flask flask-restful requests

RUN pip install --no-cache-dir django djangorestframework markdown django-filter

RUN pip install --no-cache-dir python-dotenv

RUN pip install --no-cache-dir pipenv

RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

RUN echo 'eval "`pip completion --zsh`"' >> /root/.zshrc && \
    echo 'compctl -K _pip_completion pip3' >> /root/.zshrc

EXPOSE 5000

EXPOSE 8000
