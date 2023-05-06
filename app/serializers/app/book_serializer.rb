# frozen_string_literal: true

class App::BookSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :description,
             :free,
             :image_url,
             :categories,
             :chapters

  attribute :favorited, if: :current_user?
  attribute :reading_chapter, if: :current_user?

  def current_user?
    @instance_options[:current_user].present?
  end

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def favorited
    object.favorited_by?(@instance_options[:current_user])
  end

  def reading_chapter
    ActiveModelSerializers::SerializableResource.new(
      object.reading_chapter_by(@instance_options[:current_user]).chapter,
      each_serializer: App::ChaptersSerializer
    )
  rescue StandardError
    nil
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end

  def chapters
    ActiveModelSerializers::SerializableResource.new(
      object.chapters,
      each_serializer: App::ChaptersSerializer
    )
  end
end
