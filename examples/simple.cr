require "../src/swagger"
require "../src/swagger/http/server"

builder = Swagger::Builder.new(
  title: "Simple App API Demo",
  version: "1.0.0",
  description: "Simple App API Demo document written by Crystal",
  terms_url: "https://github.com/icyleaf/swagger",
  license: Swagger::License.new("MIT", "https://opensource.org/licenses/MIT"),
  contact: Swagger::Contact.new("icyleaf", "icyleaf.cn@gmail.com", "http://icyleaf.com")
)

builder.add(Swagger::Controller.new("Users", "User Resources", [
  Swagger::Action.new("get", "/users", "List users", parameters: [
    Swagger::Parameter.new("page", "query", "integer", "Current page", default_value: 1),
    Swagger::Parameter.new("limit", "query", "integer", "How many items to return at one time (max 100)", default_value: 50),
  ]),
  Swagger::Action.new("get", "/users/{id}", "Get user by id", parameters: [Swagger::Parameter.new("id", "path")], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user")
  ]),
  Swagger::Action.new("get", "/user/{id}", "Get user by id", parameters: [Swagger::Parameter.new("id", "path")], responses: [
    Swagger::Response.new("200", "Success response"),
    Swagger::Response.new("404", "Not found user")
  ], deprecated: true)
]))

builder.add(Swagger::Server.new("http://swagger.dev:{port}/{version}/api", "Development", [
  Swagger::Server::Variable.new("port", "3000", ["3000"], "API port"),
  Swagger::Server::Variable.new("version", "v2", ["v2", "v3"], description: "API version"),
]))
builder.add(Swagger::Server.new("http://example.com/api", "Production"))

Swagger::HTTP::Server.run(builder.built)
