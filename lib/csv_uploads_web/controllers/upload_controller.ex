defmodule CsvUploadsWeb.UploadController do
  use CsvUploadsWeb, :controller

  action_fallback CsvUploadsWeb.FallbackController

  def upload(conn, params) do
    IO.inspect params
    length=1
    # dest = Path.join([:code.priv_dir(:csv_to_db), "static", "uploads", "#{Path.basename(path)}_#{entry.client_name}"])
    render(conn, "index.json", message: "Uploaded #{length} file")
  end


end
