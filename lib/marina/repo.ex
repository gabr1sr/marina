defmodule Marina.Repo do
  use Ecto.Repo,
    otp_app: :marina,
    adapter: Ecto.Adapters.Postgres
end
