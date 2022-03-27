defmodule SmartGitWeb.ReposLive do
  use SmartGitWeb, :live_view
  alias SmartGitWeb.Shared.ListRepo
  alias SmartGit.GitRepos

  def mount(_, _, socket) do
    {:ok, socket |> load_repos()}
  end

  def handle_event("load_repos", _, socket) do
    {:noreply, socket}
  end

  defp load_repos(socket) do
    repos = GitRepos.all()
    IO.inspect repos
    assign(socket, repos: repos)
  end
end
