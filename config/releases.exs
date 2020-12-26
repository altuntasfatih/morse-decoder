import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
port = System.fetch_env!("PORT")

config :morse_decoder, MorseDecoderWeb.Endpoint,
  http: [port: port],
  secret_key_base: secret_key_base,
  url: [host: {:system, "APP_HOST"}, port: {:system, "PORT"}]

config :libcluster,
  topologies: [
    default: [
      strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
      config: [
        service: "morse-decoder-nodes",
        application_name: "morse_decoder"
      ]
    ]
  ]
