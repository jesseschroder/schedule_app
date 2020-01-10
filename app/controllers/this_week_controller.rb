require_relative '../helpers/week_helper'
class ThisWeekController < BaseController
  include WeekHelper

  def index
    start, finish = this_week

    Response.new.tap do |response|
      @records = Assignment.find_by_date(start, finish)
      response.body = erb :week_index
      response.status_code = 200
    end
  end
end
