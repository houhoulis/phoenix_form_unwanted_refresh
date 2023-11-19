defmodule Phoenix179Web.FormLive do
  use Phoenix179Web, :live_view

  require Logger

  alias Phoenix179.Worker

  def mount(_params, _session, socket) do
    form_value =
      if connected?(socket) do
        0
      else
        -9999
      end

    form = to_form(%{"val" => form_value}, as: "form-test", id: "form-test-id")
    socket = assign(socket, form_test: form)

    socket =
      if connected?(socket) do
        Worker.add_player(self())

        assign(socket,
          worker_value: 0
        )
      else
        assign(socket,
          worker_value: -9999
        )
      end

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form for={@form_test}>
      <.input field={@form_test[:val]} label="A form value" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>

    <div>
      <p>New worker value: <%= @worker_value %>.</p>
    </div>
    """
  end

  def handle_info({:new_worker_value, new_worker_value}, socket) do
    {:noreply, assign(socket, worker_value: new_worker_value)}
  end
end
