# frozen_string_literal: true

class Chapter < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :book
  has_many :reading_chapters, dependent: :delete_all
end
