require_relative 'database'
require_relative 'Validations'

class BaseModel
  class InvalidParameters < StandardError; end
  include Database

  def initialize(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
    instance_variables.each { |var| self.class.send(:attr_accessor, var.to_s.delete('@')) }
  end

  class << self
    include Validations

    def create(params = {})
      instance = self.new(params)

      return unless params_valid?(params.keys.map(&:to_sym))
      return unless required_present?(instance)

      save(instance)
    end

    def all
      results = query_all(self.name)

      ret = []
      results.each do |x|
        ret << self.new(x)
      end
      ret
    end

    def find_by_date(start, finish)
      query_start = start.strftime("%Y-%m-%d")
      query_finish = finish.strftime("%Y-%m-%d")
      results = query_by_date(query_start, query_finish)

      ret = []
      results.each do |x|
        ret << self.new(x)
      end
      ret
    end

    private

    def params_valid?(keys)
      extra_params = keys - table_columns
      extra_params.empty?
    end

    def var_names(instance)
      names = []
      instance.instance_variables.each { |name|  names.push(name.to_s.delete(':@').downcase)}
      names.join(", ")
    end

    def var_values(instance)
      values = []
      instance.instance_variables.each { |var| values.push(sanitize(instance.instance_variable_get(var))) }
      values.join(', ')
    end
  end
end
