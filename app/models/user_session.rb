# frozen_string_literal: true

class UserSession < ApplicationRecord
  belongs_to :user

  validates :uuid, presence: true

  before_validation :set_uuid

  private

  def set_uuid    
    self.uuid = SecureRandom.uuid
  end
end
