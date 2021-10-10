# frozen_string_literal: true

class DrugSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower
  attributes :id, :name, :status, :max_humidity, :min_humidity, :max_temperature, :min_temperature,
             :container_id, :delivery_id
end
