defmodule SoftDeleteWeb.PageController do
  use SoftDeleteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
