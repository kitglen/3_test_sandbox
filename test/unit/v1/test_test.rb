require 'test_helper'

class V1::TestTest < ActiveSupport::TestCase
  setup do
    @test = V1::Test.new({:name=>"vwgjxwduzzjk"}, as: :"System Admin")
  end

  test "validity of test" do
    assert(@test.valid?)
  end
end