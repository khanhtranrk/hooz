# frozen_string_literal: true

class ReadingChapter < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :chapter
end
