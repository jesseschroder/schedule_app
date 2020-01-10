module Validations
  class MismatchParamsOnValidates < StandardError; end
  class InvalidParameters < StandardError; end
  class MissingRequiredParams < StandardError; end

  def required_present?(instance)
    self::REQUIRED_STUFF.each do |var|
      raise MissingRequiredParams unless instance.respond_to?(var)
    end
  rescue MissingRequiredParams
    false
  end

  def validate_presence(*options)
    raise MismatchParamsOnValidates unless params_valid?(options)
    self.const_set('REQUIRED_STUFF', options)
  end
end
