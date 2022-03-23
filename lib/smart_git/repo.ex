defmodule SmartGit.Repo do
  use Ecto.Repo,
    otp_app: :smart_git,
    adapter: Ecto.Adapters.Postgres
end
