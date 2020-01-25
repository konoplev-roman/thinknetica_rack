# frozen_string_literal: true

class App
  def call(env)
    request = Rack::Request.new(env)

    perform_request(request)
  end

  private

  def perform_request(request)
    return not_found unless request.get? && request.path == '/time'

    format = TimeFormatter.new(request.params['format'])

    return bad_request(format.errors) unless format.valid?

    build_response(format.time)
  end

  def not_found
    build_response("Not found!\n", status: 404)
  end

  def bad_request(msg)
    build_response("#{msg}\n", status: 400)
  end

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/plain' }, [body]]
  end
end
