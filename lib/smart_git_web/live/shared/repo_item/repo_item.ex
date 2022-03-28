defmodule SmartGitWeb.Shared.RepoItem do
  use SmartGitWeb, :live_component
  alias SmartGit.GitRepos

  def update(%{saved_repos: nil} = assigns, socket) do
    {:ok, socket |> assign_default(assigns) |> assign(icon: "go_to.html", color: "green")}
  end

  def update(%{id: id, saved_repos: saved_repos} = assigns, socket) do
    {:ok, socket |> assign_default(assigns) |> choose_icon(id, saved_repos)}
  end

  def handle_event("add", _, socket) do
    icon = socket.assigns.icon
    repo = socket.assigns.repo

    if icon == "go_to.html" do
      socket = push_redirect(socket, to: Routes.show_repo_path(socket, :index, repo.git_id))
      {:noreply, socket}
    else
      GitRepos.create(repo)

      socket =
        assign(socket, icon: "go_to.html", color: "green") |> assign(message: "Repo added!")

      {:noreply, socket}
    end
  end

  defp choose_icon(socket, id, saved_repos) do
    if id in saved_repos do
      assign(socket, icon: "go_to.html", color: "green")
    else
      assign(socket, icon: "add_icon.html", color: "blue")
    end
  end

  defp assign_default(socket, %{repo: repo, id: id}) do
    assign(socket, repo: repo, id: id, message: nil)
  end

  def info(assigns) do
    ~H"""
    <div class="flex items-center justify-between">
      <h3 class="text-sm font-medium"><%= @name %></h3>
      <p class="text-sm text-gray-500">
          <strong>Watchers:</strong> <%= @watchers_count %>
      </p>
    </div>
    """
  end

  def description(assigns) do
    ~H"""
    <div class="flex items-center justify-between">
      <p class="text-sm text-gray-500"><%= @description %></p>
      <a href="#" phx-click="add" phx-target={@target}>
          <%= render SmartGitWeb.SharedView, @icon, %{color: @color} %>
      </a>
    </div>
    """
  end

  def message(assigns) do
    ~H"""
    <%= if @message != nil do %>
    <div class="flex items-center justify-between">
        <div></div>
        <p class="text-sm text-green-500"><%= @message %></p>
    </div>
    <% end %>
    """
  end
end
