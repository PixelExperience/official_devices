FROM baalajimaestro/pixelexp-ci:latest

COPY . /app
WORKDIR /app

CMD ["bash", "runner.sh"]
