defmodule FoosballRushing.Repo do
  use Ecto.Repo,
    otp_app: :foosball_rushing,
    adapter: Ecto.Adapters.Postgres
end
