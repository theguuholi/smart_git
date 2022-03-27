defmodule SmartGitWeb.PageLive do
  use SmartGitWeb, :live_view
  def mount(_, _, socket) do
    language = "elixir"
    page = 1
    per_page = 10
    items = SmartGit.Github.Api.list_repo(language, page, per_page)
    {:ok, assign(socket, items: items)}
  end
end
