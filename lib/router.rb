module App
  class Router
    attr_reader :routes

    def initialize
      @routes = Hash.new { |hash, key| hash[key] = []}
    end

    def config(&block)
      instance_eval &block
    end

    def route_for(env)
      path = env["PATH_INFO"]
      method = env["REQUEST_METHOD"].downcase.to_sym
      route_array = @routes[method].detect do |route|
        case route.first
        when String
          path == route.first
        when Regexp
          path =~ route.first
        end
      end
      return route_array if route_array
      return nil
    end

    def get(path, options = {})
      @routes[:get] << [path, parse_to(options[:to])]
    end

    def post(path, options = {})
      @routes[:post] << [path, parse_to(options[:to])]
    end

    private

    def parse_to(controller_action)
      klass, method = controller_action.split('#')
      { klass: klass, method: method }
    end
  end
end
