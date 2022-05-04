# frozen_string_literal: true

module Users
  class CreateService
    prepend BasicService

    param :first_name
    param :last_name
    param :email
    param :phone_number
    param :password
    param :need_help, default: false

    attr_reader :user

    def call
      @user = User.new(
        first_name: @first_name,
        last_name: @last_name,
        email: @email,
        phone_number: @phone_number,
        password: @password,
        need_help: @need_help,
      )

      fail!(@user.errors) unless @user.save
    end
  end
end
