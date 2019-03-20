require 'rack'
require 'rack/handler/puma'
require 'puma'

class Auth
  def call(env)
    req = Rack::Request.new(env)
    # [200, {"Content-Type" => "text/html"}, ["200"]]
    [401, {"Content-Type" => "text/html"}, ["401"]]
    # [403, {"Content-Type" => "text/html"}, ["403"]]
    # case req.path_info
  end
end

Rack::Handler::Puma.run Auth.new
