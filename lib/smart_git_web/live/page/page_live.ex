defmodule SmartGitWeb.PageLive do
  use SmartGitWeb, :live_view
  alias SmartGitWeb.Shared.ListRepo
  alias SmartGit.GitRepos

  def mount(_, _, socket) do
    assigns = [language: "elixir", page: 1, per_page: 5]
    {:ok, socket}
  end

  def handle_params(params, _, socket) do
    language = params["language"] || "elixir"
    assigns = [language: language, page: 1, per_page: 5]
    socket = socket |> assign(assigns) |> load_repos() |> list_saved_repos()
    {:noreply, socket}
  end

  def handle_event("load_repos", _, socket) do
    socket = socket |> update(:page, &(&1 + 1)) |> load_repos()
    {:noreply, socket}
  end

  def handle_event("select-language", %{"language" => language}, socket) do
    socket = push_redirect(socket, to: Routes.page_path(socket, :index, language: language))
    {:noreply, socket}
  end

  defp list_saved_repos(socket) do
    saved_repos = GitRepos.get_saved_repos()
    assign(socket, saved_repos: saved_repos)
  end

  def load_repos(socket) do
    language = socket.assigns.language
    page = socket.assigns.page
    per_page = socket.assigns.per_page

    language
    |> SmartGit.Github.Api.list_repo(page, per_page)
    |> get_response(socket)
  end

  defp get_response({:error, message}, socket) do
    socket
    |> put_flash(:info, message)
    |> assign(repos: [])
  end

  defp get_response(repos, socket) do
    assign(socket, repos: repos)
  end
end
