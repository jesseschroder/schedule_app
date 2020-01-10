require_relative '../../lib/response'
require 'erb'

class BaseController
  class ViewNotFound < StandardError; end
  attr_reader :env

  def initialize(env)
    @env = env
  end

  def erb(template)
    template_file = File.read("app/views/#{template.to_s}.html.erb")
    ERB.new(template_file).result(binding)

  rescue SystemCallError
    "No available view"
  end
end
