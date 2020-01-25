# frozen_string_literal: true

class App
  def call(env)
    request = Rack::Request.new(env)

    perform_request(request)
  end

  private

  def perform_request(request)
    return not_found unless request.get? && request.path == '/time'

    build_response("Hello, World!\n")
  end

  def not_found
    build_response("Not found!\n", status: 404)
  end

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/plain' }, [body]]
  end
end
