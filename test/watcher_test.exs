defmodule CsvUploads.WatcherTest do
  use ExUnit.Case

  setup do
    pid = start_supervised(CsvUploads.Watcher)
    {:ok, watcher_pid: pid}
  end

  test "Import new csv", %{watcher_pid: pid} do
    IO.inspect(pid)
  end
end
