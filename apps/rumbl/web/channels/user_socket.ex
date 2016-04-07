defmodule Rumbl.UserSocket do
  use Phoenix.Socket

  transport :websocket, Phoenix.Transports.WebSocket

  channel "videos:*", Rumbl.VideoChannel

  @max_age 2 * 7 * 24 * 60 * 60

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: @max_age) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, reason} ->
        :error
    end
  end

  def connect(_params, socket), do: :error

  def id(_socket), do: nil
end
