# frozen_string_literal: true

class App
  def call(env)
    request = Rack::Request.new(env)

    perform_request(request)
  end

  private

  def perform_request(request)
    return not_found unless request.get? && request.path == '/time'

    time_format = parse_time_format(request)

    return bad_request('Missing time format') if time_format.empty?

    build_response(time_format.inspect)
  end

  def parse_time_format(request)
    request.params['format'].to_s.strip
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
