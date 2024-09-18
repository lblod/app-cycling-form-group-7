defmodule Dispatcher do
  use Matcher

  define_accept_types(
    json: ["application/json", "application/vnd.api+json"],
    html: ["text/html", "application/xhtml+html"],
    sparql: ["application/sparql-results+json"],
    any: ["*/*"]
  )

  define_layers([:static, :sparql, :api_services, :frontend_fallback, :resources, :not_found])

  options "/*path", _ do
    conn
    |> Plug.Conn.put_resp_header("access-control-allow-headers", "content-type,accept")
    |> Plug.Conn.put_resp_header("access-control-allow-methods", "*")
    |> send_resp(200, "{ \"message\": \"ok\" }")
  end

  ###############
  # STATIC
  ###############

  # self-service
  match "/index.html", %{layer: :static} do
    forward(conn, [], "http://frontend/index.html")
  end

  get "/assets/*path", %{layer: :static} do
    forward(conn, path, "http://frontend/assets/")
  end

  get "/@appuniversum/*path", %{layer: :static} do
    forward(conn, path, "http://frontend/@appuniversum/")
  end

  #################
  # FRONTEND PAGES
  #################

  # self-service
  match "/*path", %{layer: :frontend_fallback, accept: %{html: true}} do
    # we don't forward the path, because the app should take care of this in the browser.
    forward(conn, [], "http://frontend/index.html")
  end

  # match "/favicon.ico", @any do
  #   send_resp( conn, 404, "" )
  # end

  ###############
  # RESOURCES
  ###############

  match "/remote-data-objects/*path", %{layer: :resources, accept: %{json: true}} do
    Proxy.forward(conn, path, "http://resource/remote-data-objects/")
  end

  #################################################################
  # Dossier resources
  #################################################################

  match "/dossiers/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://resource/dossiers/")
  end

  # match "/zaken/*path", %{layer: :resources, accept: %{json: true}} do
  #   forward(conn, path, "http://resource/zaken/")
  # end

  match "/zaaks/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://resource/zaaks/")
  end

  match "/procedurestaps/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://resource/procedurestaps/")
  end

  #################################################################
  # Besluit resources
  #################################################################
  match "/bestuurseenheden/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://cache/bestuurseenheden/")
  end

  match "/werkingsgebieden/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://cache/werkingsgebieden/")
  end

  match "/bestuurseenheid-classificatie-codes/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://cache/bestuurseenheid-classificatie-codes/")
  end

  #################################################################
  # Concept scheme resources
  #################################################################
  get "/concept-schemes/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://cache/concept-schemes/")
  end

  get "/concepts/*path", %{layer: :resources, accept: %{json: true}} do
    forward(conn, path, "http://cache/concepts/")
  end

  #################################################################
  # Login logic
  #################################################################
  match "/mock/sessions/*path" do
    forward(conn, path, "http://mocklogin/sessions/")
  end

  match "/gebruikers/*path", %{layer: :resources, accept: %{any: true}} do
    forward(conn, path, "http://cache/gebruikers/")
  end

  match "/accounts/*path", %{layer: :resources, accept: %{any: true}} do
    forward(conn, path, "http://cache/accounts/")
  end

  match "/sessions/*path", %{layer: :api_services, accept: %{any: true}} do
    Proxy.forward(conn, path, "http://login/sessions/")
  end
  
  #################################################################
  # OPEN DATABASE (REMOVE BEFORE DEPLOYING TO PROD)
  # We use this endpoint to bypass mu-auth in a regular application this would be done in a microservice
  # Only exposing the data we actually need and with security in mind
  #################################################################
  match "/sparql/*path" do
    Proxy.forward conn, path, "http://virtuoso:8890/sparql/"
  end

  #################
  # NOT FOUND
  #################
  match "/*_path", %{layer: :not_found} do
    send_resp(conn, 404, "Route not found.  See config/dispatcher.ex")
  end
end
