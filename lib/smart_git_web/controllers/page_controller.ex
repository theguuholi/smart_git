defmodule SmartGitWeb.PageController do
  use SmartGitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
