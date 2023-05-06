# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user

  has_one :device, dependent: :destroy
end
