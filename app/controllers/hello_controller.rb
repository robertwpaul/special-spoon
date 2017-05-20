class HelloController < ApplicationController
  def index
    json_response({message: 'Hello World'})
  end
end
