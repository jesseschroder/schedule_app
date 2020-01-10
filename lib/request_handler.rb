require_relative 'router'
module App
  class RequestHandler
     attr_reader :router, :database

    def initialize(database = nil)
      @router = App::Router.new
      @database = database
    end

     def call(env)
       route = @router.route_for(env)
       if route
         response = handle_request(route, env)
         return response.rack_response
       else
         return [404, {}, ['404 - Page not found']]
       end
     end

     private

     def handle_request(route, env)
       controller = Module.const_get(route.last[:klass] + "Controller")
       method = route.last[:method].to_sym
       controller.new(env).send(method)
     end
  end
end
