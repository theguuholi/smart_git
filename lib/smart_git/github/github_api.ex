defmodule SmartGit.Github.Api do
  use Tesla

  @middleware [
    {Tesla.Middleware.BaseUrl, "https://api.github.com"},
    Tesla.Middleware.JSON
  ]

  # https://docs.github.com/pt/rest/reference/search#search-repositories
  def list_repo(language, page, per_page) do
    @middleware
    |> Tesla.client()
    |> get("/search/repositories",
      query: [q: "language:#{language}", sort: "stars", order: "desc", page: page, per_page: per_page]
    )
    |> then(&prepare_result/1)
  end

  defp prepare_result({:ok, %{status: 403}}) do
    {:error, "Limite excedido espere mais um pouco"}
  end

  defp prepare_result({:ok, %{body: %{"items" => items}}}) do
    items
    |> Enum.map(fn item ->
      %{
        "owner" => %{"avatar_url" => avatar_url},
        "full_name" => full_name,
        "name" => name,
        "id" => id,
        "watchers_count" => watchers_count,
        "forks" => forks,
        "description" => description,
        "url" => url,
        "language" => language,
        "open_issues" => open_issues,
      } = item

      %{
        git_id: id,
        avatar_url: avatar_url,
        full_name: full_name,
        watchers_count: watchers_count,
        forks: forks,
        description: description,
        url: url,
        name: name,
        open_issues: open_issues,
        language: language
      }
    end)
  end
end
