require 'rubygems'
require 'sinatra'

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.default_timezone = :utc

db_file_name = if defined?(SINATRA_ENV) && SINATRA_ENV=="test"
                 "test.sqlite3"
               else
                 "development.sqlite3"
               end

db_file = File.expand_path(File.dirname(__FILE__) + "/../lsrc-training-center/db/#{db_file_name}")

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => db_file)



class ScheduleItem < ActiveRecord::Base
  @t = self.arel_table
  
  scope :now, lambda{ where(@t[:start_at].lteq(Time.now.utc)).where(@t[:end_at].gteq(Time.now.utc)).limit(1) }
end

get '/now_playing' do
  item = ScheduleItem.now.first
  if item
    "Now Playing: #{item.title} until #{item.end_at}"
  else
    "Closed"
  end
end