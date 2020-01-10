require_relative 'base_model'

class Assignment < BaseModel
  validate_presence :due_date, :title

end
