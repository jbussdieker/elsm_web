require ::File.expand_path('../../config/application',  __FILE__)

describe 'Elsm' do
  include Rack::Test::Methods

  def app
    Elsm::Application
  end

  it "should work" do
    get '/'
    last_response.should be_ok
    last_response.body.should == "OK"
  end
end
