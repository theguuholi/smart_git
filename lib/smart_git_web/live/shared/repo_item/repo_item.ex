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
      # socket = push_redirect(socket, to: Routes.git_repo_path(socket, :index, repo.id))
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
end
