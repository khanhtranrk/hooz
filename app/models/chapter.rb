# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :book
  has_many :reading_chapters, dependent: :delete_all
end
