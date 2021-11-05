defmodule CsvUploadsWeb.UploadController do
  use CsvUploadsWeb, :controller

  action_fallback CsvUploadsWeb.FallbackController

  def index(conn, %{"file" => %{content_type: "text/csv", filename: filename, path: path}}) do
    dest =
      Path.join([
        :code.priv_dir(:csv_uploads),
        "static",
        "uploads",
        "#{Path.basename(path)}_#{filename}"
      ])

    case File.cp(path, dest) do
      :ok -> json(conn, %{message: "Arquivo enviado para o servidor com sucesso!!"})
      _error -> json(conn, %{error: "Ocorreu um erro ao salvar o arquivo"})
    end
  end

  def index(conn, _) do
    json(conn, %{error: "requisição inválida"})
  end
end
