# myapp.rb
require 'rubygems'
require 'sinatra'

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => File.expand_path(File.dirname(__FILE__) + "/../lsrc-training-center/db/development.sqlite3"))

class ScheduleItem < ActiveRecord::Base
end

get '/now_playing' do
  item = ScheduleItem.last
 "Now Playing: #{item.title} until #{item.end_at}"
end