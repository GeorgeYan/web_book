require 'spec_helper'

describe "home page" do
  it "displays the user's username after successful login" do
    user = User.create!(:email => "1234@124.com", :password => "12341234", :password_confirmation => "12341234")
    get "/login"
    assert_select "form.login" do
      assert_select "input[name=?]", "email"
      assert_select "input[name=?]", "password"
      assert_select "input[name=?]", "password_confirmation"
      assert_select "input[type=?]", "submit"
    end

    post "login", :email => "1234@124.com", :password => "12341234", :password_confirmation => "12341234"
    assert_select ".header .username", :text => "1234@124.com"
  end
end
