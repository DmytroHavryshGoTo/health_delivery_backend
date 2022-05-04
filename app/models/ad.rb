# frozen_string_literal: true

class Ad < ApplicationRecord
  validates :name, :description, :address, presence: true
  belongs_to :user
  has_one :delivery
end
