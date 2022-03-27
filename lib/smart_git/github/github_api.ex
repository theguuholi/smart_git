defmodule SmartGit.Github.Api do
  use Tesla

  @middleware [
    {Tesla.Middleware.BaseUrl, "https://api.github.com"},
    Tesla.Middleware.JSON
  ]

  def list_repo(language, page, per_page) do
    # @middleware
    # |> Tesla.client()
    # |> get("/search/repositories",
    #   query: [q: "language:#{language}", sort: "start", order: "desc", page: page, per_page: per_page]
    # )
    # |> then(&prepare_result/1)
    Enum.map(1..20, fn _ ->
      %{
        avatar_url: "https://avatars.githubusercontent.com/u/60711?v=4",
        description: "A community driven style guide for Elixir",
        forks: 293,
        full_name: "christopheradams/elixir_style_guide",
        id: :rand.uniform,
        language: "Elixir",
        name: "elixir_style_guide",
        open_issues: 7,
        url: "https://api.github.com/repos/christopheradams/elixir_style_guide",
        watchers_count: 3955
      }
    end)

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
        id: id,
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
      |> IO.inspect()
    end)
  end
end
