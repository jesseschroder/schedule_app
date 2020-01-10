class AssignmentsController < BaseController

  def index
    Response.new.tap do |response|
      @records = Assignment.all
      response.body = erb :assignments_index
      response.status_code = 200
    end
  end

  def show
    Response.new.tap do |response|
      response.body = "This will  be assignment show"
      response.status_code = 200
    end
  end

  def create
    Response.new.tap do |response|
      params = JSON.parse(@env['rack.input'].read)
      if Assignment.create(params)
        response.body = " created!"
        response.status_code = 200
        else
        response.body = "u fucked up"
        response.status_code = 422
      end
    end
  end
end
