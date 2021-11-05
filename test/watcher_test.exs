defmodule CsvUploads.WatcherTest do
  # # use CsvUploads.DataCase
  # use ExUnit.Case

  # alias CsvUploads.Accounts
  # alias CsvUploads.Watcher

  # setup do
  #   Ecto.Adapters.SQL.Sandbox.checkout(CsvUploads.Repo)
  #   {:ok, pid} = start_supervised({Watcher, [name: :test, dirs: ["priv/static/uploads"]]})
  #   {:ok, watcher_pid: pid}
  # end

  # test "Import new csv", %{watcher_pid: pid} do
  #   timestamp = DateTime.utc_now() |> DateTime.to_unix()

  #   File.write(
  #     "priv/static/uploads/#{timestamp}_test.csv",
  #     "name;email;password\nsome_name;some@email;secret"
  #   )

  #   assert Watcher.get_user_by_email("some@email") == %Accounts.User{}
  # end
end
