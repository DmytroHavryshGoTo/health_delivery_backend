# frozen_strin_literal: true

module Users
  class UpdateService
    prepend BasicService

    option :id
    option :first_name
    option :last_name
    option :email
    option :password, optional: true
  
    attr_reader :user

    def call
      @user = User.find(id)
      update_attrs
      update_password if password.present?
    end

    private

    def update_attrs
      fail!(@user.errors) unless @user.update(
        first_name: first_name,
        last_name: last_name,
        email: email
      )
    end

    def update_password
      fail!(@user.errors) unless @user.update(password: password)
    end
  end
end
