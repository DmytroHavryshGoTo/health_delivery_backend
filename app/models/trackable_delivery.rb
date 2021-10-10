# frozen_string_literal: true

class TrackableDelivery < ApplicationRecord
  belongs_to :user
  belongs_to :delivery
end
