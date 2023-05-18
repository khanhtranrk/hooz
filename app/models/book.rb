# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :image

  has_many :book_categories, dependent: :delete_all
  has_many :categories, through: :book_categories
  has_many :chapters, dependent: :delete_all
  has_many :reading_chapters, dependent: :delete_all
  has_many :favoritez, class_name: 'Favorite', inverse_of: :book, dependent: :delete_all
  has_many :users_favorited, through: :favoritez, source: :user

  def favorited_by?(user)
    favoritez.exists?(user:)
  end

  def reading_chapter_by(user)
    reading_chapters.find_by(user:)
  end

  class << self
    def filter(params)
      books = all

      books = books.where(free: params[:free]) if params[:free].present?

      if params[:category_ids].present?
        category_ids = params[:category_ids].split(',').map(&:to_i)
        books_ids = BookCategory.where(category_id: category_ids).pluck(:book_id)
        books = books.where(id: books_ids)
      end

      if params[:query].present?
        query = params[:query].strip

        books = books.where(
          'name ILIKE ? OR other_names ILIKE ? OR description ILIKE ? OR author ILIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
        )
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[views favorites updated_at created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "books.#{t[0]} #{t[1]}" }

        books = books.order(sort_by.join(', '))
      end

      books
    end
  end
end
