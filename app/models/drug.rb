# frozen_string_literal: true

class Drug < ApplicationRecord
  belongs_to :delivery

  enum status: {
    good: 0,
    exceeded_min_temperature: 1,
    exceeded_min_humidity: 2,
    exceeded_max_temperature: 3,
    exceeded_max_humidity: 4
  }
end
