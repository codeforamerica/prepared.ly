require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
   
  test "does the user object exist" do
  if @user.exists?
    assert true
  end
end
end
