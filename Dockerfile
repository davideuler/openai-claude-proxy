FROM python:3.10-alpine
LABEL maintainer="kunyuan"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=America/New_York
RUN apk update && \
    apk add tzdata --no-cache && \
    cp /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apk del tzdata && \
    mkdir -p /usr/share/zoneinfo/America/ && \
    ln -s /etc/localtime /usr/share/zoneinfo/America/New_York

COPY . /home/openai-forward
WORKDIR /home/openai-forward
RUN pip install --no-cache-dir -r requirements.txt

ENV ssl_keyfile="/home/openai-forward/privkey.pem"
ENV ssl_certfile="/home/openai-forward/fullchain.pem"
EXPOSE 8000
ENTRYPOINT ["python", "-m", "openai_forward.__main__", "run"]
