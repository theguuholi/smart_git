defmodule SmartGitWeb.ShowRepoLive do
  use SmartGitWeb, :live_view
  alias SmartGit.GitRepos

  def mount(%{"id" => git_id}, _, socket) do
    repo = GitRepos.get_by_git_id(git_id)
    IO.inspect repo
    {:ok, assign(socket, repo: repo)}
  end
end
