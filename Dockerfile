FROM python:3.9-slim

MAINTAINER jhao104 <j_hao104@163.com>

WORKDIR /app

COPY ./requirements.txt .
# timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# runtime environment
RUN --mount=type=cache,target=/root/.cache \
    apt update && \
    apt install -y curl musl gcc libcurl4-openssl-dev libssl-dev && \
    ln -s /lib/x86_64-linux-musl/libc.so  /lib/libc.musl-x86_64.so.1

RUN --mount=type=cache,target=/root/.cache \
    pip install --no-cache-dir -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

COPY . .

EXPOSE 5010

ENTRYPOINT ["/bin/sh", "start.sh" ]
