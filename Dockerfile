FROM elixir:1.8.1-slim

WORKDIR /app
RUN chmod -R 777 /app

RUN mix local.rebar --force
RUN mix local.hex --force

EXPOSE 8080

COPY . .

ENV DB_NAME=api_banking
ENV DB_USER=apibanking
ENV DB_PASSWORD=3xt4dwpb
ENV DB_HOST=localhost
ENV DB_PORT=8285

RUN mix deps.clean --all
RUN mix deps.get
RUN mix deps.compile --all
RUN mix compile
RUN mix release.init
RUN MIX_ENV=prod mix release

CMD _build/prod/rel/api_banking/bin/api_banking foreground
