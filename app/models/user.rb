# frozen_string_literal: true

class User < ApplicationRecord
  include Notificationable

  has_secure_password

  has_one_attached :avatar

  has_one :verification, dependent: :destroy
  has_many :sessions, dependent: :delete_all
  has_many :favorites, dependent: :delete_all
  has_many :reading_chapters, dependent: :delete_all
  has_many :purchases, dependent: :delete_all

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
  validates :email,
            :password,
            presence: true

  REQUIRED_ATTRIBUTES = %i[email password].freeze

  def current_plan
    purchases.find_by('NOW()::TIMESTAMP > effective_date::TIMESTAMP AND NOW()::TIMESTAMP < expiry_date::TIMESTAMP')
  end
end
