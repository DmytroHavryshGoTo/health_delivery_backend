# frozen_string_literal: true

class DeliverySerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  attributes :id, :user_id, :route, :ttn, :name, :lat, :lon
  has_many :drugs

  attribute :status do |object|
    object.delivery_status
  end

  attribute :created_at do |object|
    object.created_at.strftime('%F')
  end

  attribute :estimated_delivery_date do |object|
    object.estimated_delivery_date.strftime('%F')
  end
end
