# frozen_string_literal: true

class Admin::ChapterSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :content
end
