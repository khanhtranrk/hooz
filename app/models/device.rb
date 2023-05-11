# frozen_string_literal: true

class Device < ApplicationRecord
  scope :owned_by, ->(user_id) { where(session_id: Session.where(user_id:)) }

  belongs_to :session
end
