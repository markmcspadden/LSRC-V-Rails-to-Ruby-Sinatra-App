SINATRA_ENV="test"

require 'now_playing'
require 'test/unit'
require 'rack/test'
require 'active_support/core_ext/time/calculations'

class NowPlayingTest < Test::Unit::TestCase
  include Rack::Test::Methods  

  def app
    Sinatra::Application
  end

  def test_active_record_presense
    assert defined?(ActiveRecord::Base)
  end
  
  def test_active_record_connection
    assert ActiveRecord::Base.connection
  end
  
  def test_active_record_default_timezone
    # TRUST ME. DO THIS.
    assert_equal :utc, ActiveRecord::Base.default_timezone
  end

  def test_now_playing_with_item
    now = Time.now
    start_at = now.advance(:minutes => -5)
    end_at = now.advance(:minutes => 30)
    
    ScheduleItem.destroy_all
    ScheduleItem.create!(:title => "Sinatra Testing", :start_at => start_at, :end_at => end_at)
    ScheduleItem.create!(:title => "Sinatra Testing", :start_at => nil, :end_at => nil)
    
    get '/now_playing'
    assert_equal "Now Playing: Sinatra Testing until #{end_at}", last_response.body
  end
  
  def test_now_playing_without_item    
    ScheduleItem.destroy_all
    
    get '/now_playing'
    assert_equal "Closed", last_response.body
  end
end