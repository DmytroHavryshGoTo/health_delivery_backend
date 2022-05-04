# frozen_string_literal: true

class AdSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  attributes :id, :name, :description, :address, :completed, :status

  belongs_to :user
  has_one :delivery

  attribute :status do |object|
    if object.completed?
      'completed'
    elsif object.delivery.present?
      'inProgress'
    else
      'waiting'
    end
  end
end
