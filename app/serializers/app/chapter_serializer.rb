# frozen_string_literal: true

class App::ChapterSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :content
end
