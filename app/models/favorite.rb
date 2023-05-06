# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, uniqueness: { scope: %i[book_id] }
end
