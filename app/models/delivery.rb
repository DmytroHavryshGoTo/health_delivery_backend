# frozen_string_literal: true

class Delivery < ApplicationRecord
  serialize :route, Array

  validates :name, :ttn, :estimated_delivery_date, presence: true
  belongs_to :user
  belongs_to :ad, optional: true
  has_many :drugs, dependent: :destroy
  has_many :trackable_deliveries, dependent: :destroy
  has_many :users, through: :trackable_deliveries, source: :user

  enum delivery_status: {
    preparing_to_deliver: 0,
    delivering: 1,
    delivered: 2,
  }

  before_validation :set_ttn

  def current_station
    station = route.find { |s| s[:current] }
    station ? station[:name] : ''
  end

  private

  def set_ttn
    self.ttn = SecureRandom.hex
  end
end
