#\ -w -p 8765

require 'bundler'
Bundler.require

# Load the DB and table

database = Mysql2::Client.new(host: "localhost", username: "root", password: "", database: "new")
database.query <<-SQL
    CREATE TABLE IF NOT EXISTS assignments (
      id INTEGER PRIMARY KEY AUTO_INCREMENT,
      title  TEXT,
      due_date TEXT,
      module   INT
    );
SQL

# Load the RequestHandler
require_relative 'lib/request_handler'
ScheduleApp = App::RequestHandler.new(database)

# Load the routes
require File.join(File.dirname(__FILE__),'config', 'routes')

Dir["app/controllers/*"].each {|file| require_relative file }
Dir["app/models/*"].each {|file| require_relative file }
Dir["app/helpers/*"].each { |file| require_relative file }


run ScheduleApp




