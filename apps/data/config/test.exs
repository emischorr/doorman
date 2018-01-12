use Mix.Config

config :data, Data.Repo,
  database: "doorman_test",
  username: "doorman",
  password: "doorman",
  hostname: "localhost"
