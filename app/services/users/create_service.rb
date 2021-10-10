# frozen_string_literal: true

module Users
  class CreateService
    prepend BasicService

    param :first_name
    param :last_name
    param :email
    param :password

    attr_reader :user

    def call
      @user = User.new(
        first_name: @first_name,
        last_name: @last_name,
        email: @email,
        password: @password
      )

      fail!(@user.errors) unless @user.save
    end
  end
end
