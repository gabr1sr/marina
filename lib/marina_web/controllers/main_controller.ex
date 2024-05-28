defmodule MarinaWeb.MainController do
  use MarinaWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.report_path(conn, :index))
  end
end
