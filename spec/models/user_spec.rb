require 'spec_helper'

describe User do
  it 'orders by email' do
    foo = User.create!(email: "123@12.com",password:"12341234",password_confirmation:"12341234")
    bar = User.create!(email: "Wwer@qq.com",password:"12341234",password_confirmation:"12341234")

  end
end
