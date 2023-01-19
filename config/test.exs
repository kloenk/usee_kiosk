import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :usee_kiosk, UseeKioskWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nbMp4EoHnCrNx7ZnuFhr+xr1AGIGuSLptiYelWBVUbk6v2fJF0z4ZuIMkQehzHsx",
  server: false

# In test we don't send emails.
config :usee_kiosk, UseeKiosk.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
