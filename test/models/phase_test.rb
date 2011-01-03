require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PhaseControllerTest < Test::Unit::TestCase
  context "Phase Model" do
    should 'construct new instance' do
      @phase = Phase.new
      assert_not_nil @phase
    end
  end
end
