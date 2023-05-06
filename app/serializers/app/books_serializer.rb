# frozen_string_literal: true

class App::BooksSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :description,
             :free,
             :image_url

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end
end
