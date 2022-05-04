# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  attributes :id, :first_name, :last_name, :email, :admin, :need_help, :phone_number
end
