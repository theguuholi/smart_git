defmodule SmartGitWeb.PageLive do
  use SmartGitWeb, :live_view
  alias SmartGitWeb.Shared.ListRepo
  alias SmartGit.GitRepos

  def mount(_, _, socket) do
    assigns = [language: "elixir", page: 1, per_page: 5]
    {:ok, socket |> assign(assigns) |> load_repos() |> list_saved_repos(), temporary_assigns: [repos: []]}
  end

  def handle_event("load_repos", _, socket) do
    socket = socket |> update(:page, &(&1 + 1)) |> load_repos()
    {:noreply, socket}
  end

  def handle_event("select-language", %{"language" => language}, socket) do
    {:noreply, socket |> assign(language: language) |> assign(repos: []) |> load_repos()}
  end

  defp list_saved_repos(socket) do
    saved_repos = GitRepos.get_saved_repos()
    assign(socket, saved_repos: saved_repos)
  end

  def load_repos(socket) do
    language = socket.assigns.language
    page = socket.assigns.page
    per_page = socket.assigns.per_page
    repos = SmartGit.Github.Api.list_repo(language, page, per_page)
    assign(socket, repos: repos)
  end
end
