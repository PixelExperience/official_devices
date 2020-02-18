FROM baalajimaestro/pixelexp-ci:latest

COPY . /app
WORKDIR /app

RUN cargo build

CMD ["bash", "runner.sh"]
