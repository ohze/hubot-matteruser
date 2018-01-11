FROM node:alpine

ARG hubot_owner=ohze
ARG hubot_name=ohze-bot
ARG hubot_description="ohze bot"

RUN npm install -g yo generator-hubot && \
  adduser -h /hubot -s /bin/sh -S hubot

USER  hubot
WORKDIR /hubot

RUN echo "n" | yo hubot --adapter matteruser \
    --owner="${hubot_owner}" \
    --name="${hubot_name}" \
    --description="${hubot_desciption}" \
    --defaults && \
  rm hubot-scripts.json && \
  npm install hubot-matteruser \
    hubot-jira-bot \
    hubot-jira-links

COPY external-scripts.json external-scripts.json

CMD ["./bin/hubot", "-a", "matteruser"]

EXPOSE 8080
