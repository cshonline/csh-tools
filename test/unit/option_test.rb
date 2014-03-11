require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "hello" do
    assert options(:qihu_call).symbol == "qihu"
    assert options(:qihu_call).type == "call"
  end
end
