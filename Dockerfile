ARG MIX_ENV="prod"

FROM hexpm/elixir:1.12.2-erlang-24.0.5-alpine-3.14.0 as build

RUN apk add --no-cache build-base git python3 curl npm

WORKDIR /app

RUN mix local.hex --force \
  && mix local.rebar --force

ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

COPY config/config.exs config/$MIX_ENV.exs config/
RUN mix deps.compile

COPY assets/package.json assets/yarn.lock assets/
RUN npm install --global yarn \
  && cd assets \
  && yarn install --frozen-lockfile

COPY assets assets
RUN mix assets.deploy

COPY lib lib
RUN mix compile
COPY config/runtime.exs config/
RUN mix release

# Create final image for production usage
FROM alpine:3.14.2
RUN apk add --no-cache libstdc++ openssl ncurses-libs

ARG MIX_ENV
ENV USER="notebookgarden"
WORKDIR "/home/${USER}/app"

ENTRYPOINT ["bin/notebookgarden"]
CMD ["start"]

RUN \
  addgroup \
  -g 1000 \
  -S "${USER}" \
  && adduser \
  -s /bin/sh \
  -u 1000 \
  -G "${USER}" \
  -h /home/notebookgarden \
  -D "${USER}" \
  && su "${USER}"

COPY --from=build --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/notebookgarden ./

USER "${USER}"
