ARG TZ=Europe/Rome
ARG QBITTORRENT_IP=localhost
ARG QBITTORRENT_USER=admin
ARG QBITTORRENT_PORT=8080
ARG QBITTORRENT_PASSWORD=adminadmin
ARG TELEGRAM_TOKEN
ARG TELEGRAM_USER_IDS

FROM python:3.7-slim
RUN mkdir /code
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
RUN echo "${TZ}" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV TZ=${TZ}
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN eval "echo \"$(cat login.json.template)\">login.json"
COPY . .
CMD [ "python", "/code/main.py" ]
