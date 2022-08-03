defmodule SupermarketWeb.ErrorViewTest do
  use SupermarketWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @tag :normal
  test "renders 404.json" do
    assert render(SupermarketWeb.ErrorView, "404.json", []) == %{
             errors: %{detail: "Not Found"}
           }
  end

  @tag :normal
  test "renders 500.json" do
    assert render(SupermarketWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
