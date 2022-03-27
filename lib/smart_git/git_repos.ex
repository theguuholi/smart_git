defmodule SmartGit.GitRepos do
  import Ecto.Query
  alias SmartGit.GitRepos.GitRepo
  alias SmartGit.Repo

  def create(%{id: id} = repo) do
    repo = repo |> Map.delete(:id) |> Map.put(:git_id, id)

    %GitRepo{}
    |> GitRepo.changeset(repo)
    |> Repo.insert()
  end

  def get_saved_repos() do
    GitRepo
    |> select([g], g.git_id)
    |> Repo.all()
  end

  def all(), do: Repo.all(GitRepo)
end
