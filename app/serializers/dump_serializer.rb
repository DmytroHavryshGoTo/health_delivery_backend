# frozen_string_literal: true

class DumpSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  attributes :id, :url

  attribute :creator do |object|
    object.user&.full_name || '(Deleted)' 
  end

  attribute :created_at do |object, params|
    pattern = params[:locale] == 'en' ? '%m-%d-%Y - %l %p' : '%d-%m-%Y - %k:%M'
    object.created_at.strftime(pattern)
  end
end
