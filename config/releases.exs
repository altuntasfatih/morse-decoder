import Config

service_name = System.fetch_env!("SERVICE_NAME")
secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
port = System.fetch_env!("PORT")

config :morse_decoder, MorseDecoderWeb.Endpoint,
  http: [port: port],
  secret_key_base: secret_key_base,
  url: [host: {:system, "APP_HOST"}, port: {:system, "PORT"}]

config :peerage,
  via: Peerage.Via.Dns,
  dns_name: "morse_decoder",
  app_name: "morse_decoder"
