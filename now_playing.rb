require 'rubygems'
require 'sinatra'

db_file_name = if defined?(SINATRA_ENV) && SINATRA_ENV=="test"
                 "test.sqlite3"
               else
                 "development.sqlite3"
               end

db_file = File.expand_path(File.dirname(__FILE__) + "/../lsrc-training-center/db/#{db_file_name}")

class ScheduleItem
end

get '/' do
  "Hello World!"
end