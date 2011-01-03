require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ProjectControllerTest < Test::Unit::TestCase
  context "Project Model" do
    should 'construct new instance' do
      @project = Project.new
      assert_not_nil @project
    end
  end
end
