FROM baalajimaestro/pixelexp-ci:latest

RUN mkdir /app
COPY . /app
WORKDIR /app
RUN npm install glob

CMD ["bash", "runner.sh"]
