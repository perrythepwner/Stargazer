FROM python:3.12-slim-bookworm as runner

COPY ./backend/requirements.txt /tmp/requirements.txt

RUN apt update && \
    apt install -y \
    socat \
    supervisor

RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt

RUN addgroup -m ctf

COPY ./backend/entrypoint.sh /
COPY ./backend/eth_sandbox/ /usr/lib/python/eth_sandbox/
COPY ./backend/contracts/ /home/ctf/backend/contracts/

COPY ./config/ /startup/
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN true && \
    cd /home/ctf/backend/contracts/ && \
    forge build --out ./compiled && \
    true

ENV PYTHONPATH=/usr/lib/python/
ENV PYTHONUNBUFFERED=1

RUN chmod +x /entrypoint.sh && \
    mkdir -p /var/log/ctf/ && \
    chown -R ctf:ctf /var/log/ctf/ && \
    chmod 777 /var/log/ctf/ && \
    chown -R ctf:ctf /home/ctf/
    
USER ctf
WORKDIR /home/ctf/

ENTRYPOINT [ "/entrypoint.sh" ]