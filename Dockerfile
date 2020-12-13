ARG TZ
ARG QBITTORRENT_IP=localhost
ARG QBITTORRENT_USER=admin
ARG QBITTORRENT_PORT=8080
ARG QBITTORRENT_PASSWORD=adminadmin
ARG TELEGRAM_TOKEN
ARG TELEGRAM_USER_IDS

ENV TZ=${TZ:-Europe/Rome}
ENV QBITTORRENT_IP=${QBITTORRENT_IP:-localhost}
ENV QBITTORRENT_USER=${QBITTORRENT_USER:-admin}
ENV QBITTORRENT_PORT=${QBITTORRENT_PORT:-8080}
ENV QBITTORRENT_PASSWORD=${QBITTORRENT_PASSWORD:-adminadmin}
ENV TELEGRAM_TOKEN=${TELEGRAM_TOKEN:-Telegram bot token must be set!}
ENV TELEGRAM_USER_IDS=${TELEGRAM_USER_IDS:-Telegram user ids must be set!}


FROM python:3.7
RUN mkdir /code
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo "$TZ" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV TZ=$TZ
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY login.json.template ./

RUN eval "echo \"$(cat ./login.json.template)\">./login.json"
RUN eval "cat login.json"
COPY . .
CMD [ "python", "/code/main.py" ]
