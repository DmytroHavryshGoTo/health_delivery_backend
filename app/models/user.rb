# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sessions, class_name: 'UserSession', dependent: :delete_all
  has_many :trackable_deliveries, dependent: :destroy
  has_many :deliveries, through: :trackable_deliveries, source: :delivery
  has_many :dumps, dependent: :nullify

  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }

  has_secure_password

  def full_name
    first_name + ' ' + last_name
  end
end
