defmodule CsvUploads.Watcher do
  use GenServer

  alias CsvUploads.Accounts

  def start_link(_init_args) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(__MODULE__,
      name: __MODULE__,
      dirs: [Path.join([:code.priv_dir(:csv_uploads), "static", "uploads"])]
    )
  end

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    FileSystem.subscribe(watcher_pid)
    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info(
        {:file_event, watcher_pid, {path, [:created]}},
        %{watcher_pid: watcher_pid} = state
      ) do
    [header | rows] =
      File.read!(path)
      |> String.split(["\r\n", "\n"])
      |> Enum.reject(&(&1 == ""))

    keys = String.split(header, ";") |> Enum.map(&String.to_atom(&1))

    rows
    |> Enum.map(fn row ->
      values = String.split(row, ";")

      with args when is_list(args) <- Enum.zip(keys, values),
           attrs when is_map(attrs) <- Enum.into(args, %{}),
           {:ok, _} <- Accounts.create_user(attrs) do
        :ok
      else
        _ -> :error
      end
    end)

    {:noreply, state}
  end

  def handle_info({:file_event, _watcher_pid, {_path, _events}}, state) do
    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    # YOUR OWN LOGIC WHEN MONITOR STOP
    GenServer.stop(watcher_pid, :normal)
    {:noreply, state}
  end
end
