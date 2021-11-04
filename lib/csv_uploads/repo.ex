defmodule CsvUploads.Repo do
  use Ecto.Repo,
    otp_app: :csv_uploads,
    adapter: Ecto.Adapters.Postgres
end
