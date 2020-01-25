# frozen_string_literal: true

class App
  def call(_env)
    build_response("Hello, World!\n")
  end

  private

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/plain' }, [body]]
  end
end
