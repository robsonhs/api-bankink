FROM elixir:1.8.1-slim

WORKDIR /app
RUN chmod -R 777 /app

RUN mix local.rebar --force
RUN mix local.hex --force

COPY . .

ARG DB_NAME
ENV DB_NAME=${DB_NAME}
ARG DB_USER
ENV DB_USER=${DB_USER}
ARG DB_PASSWORD
ENV DB_PASSWORD=${DB_PASSWORD}
ARG DB_HOST
ENV DB_HOST=${DB_HOST}
ARG DB_PORT
ENV DB_PORT=${DB_PORT}

RUN mix deps.clean --all
RUN mix deps.get
RUN mix deps.compile --all
RUN mix compile
RUN mix release.init
RUN MIX_ENV=prod mix release

CMD _build/prod/rel/api_banking/bin/api_banking foreground
