FROM elixir:1.9 AS builder
ENV MIX_ENV=prod
WORKDIR /usr/local/decoder
# This step installs all the build tools we'll need
RUN mix local.rebar --force && \
    mix local.hex --force
# Copies our app source code into the build container
COPY . .
# Compile Elixir
RUN mix do deps.get, deps.compile, compile

# Build Release
RUN mkdir -p /opt/release \
    && mix release \
    && mv _build/${MIX_ENV}/rel/morse_decoder /opt/release


# Create the runtime container
FROM erlang:22 as runtime
WORKDIR /usr/local/decoder
COPY --from=builder /opt/release/morse_decoder .

CMD [ "bin/morse_decoder", "start" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 \
 CMD nc -vz -w 2 localhost 4000 || exit 1