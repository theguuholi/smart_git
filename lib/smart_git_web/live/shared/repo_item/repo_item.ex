defmodule SmartGitWeb.Shared.RepoItem do
  use SmartGitWeb, :live_component

  def handle_event("add", _, socket) do
    IO.inspect socket.assigns.repo
    {:noreply, socket}
  end
end
