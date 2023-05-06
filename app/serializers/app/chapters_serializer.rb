# frozen_string_literal: true

class App::ChaptersSerializer < ActiveModel::Serializer
  attributes :id,
             :name
end
