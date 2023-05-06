# frozen_string_literal: true

class Api::V1::App::BooksController < ApplicationController
  before_action :set_book, except: %i[index show favorited read]

  def index
    books = Book.filter(params)
                .where(active: true)
                .with_attached_image

    paginate books,
             each_serializer: App::BooksSerializer,
             base_url: request.base_url
  end

  def show
    book = Book.includes(:categories, :chapters)
               .find_by!(id: params[:id], active: true)

    expose book,
           serializer: App::BookSerializer,
           current_user: @current_user,
           base_url: request.base_url
  end

  def favorite
    Favorite.create!(book: @book, user: @current_user)

    @book.update(favorites: @book.favorites + 1)

    expose
  end

  def unfavorite
    Favorite.find_by!(book: @book, user: @current_user)
            .destroy!

    @book.update(favorites: @book.favorites - 1)

    expose
  end

  def favorited
    books = Book.where(id: @current_user.favorites.pluck(:book_id), active: true)

    paginate books,
             each_serializer: App::BooksSerializer,
             base_url: request.base_url
  end

  def read
    books = Book.where(id: @current_user.reading_chapters.pluck(:book_id), active: true)

    paginate books,
             each_serializer: App::BooksSerializer,
             base_url: request.base_url
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id], active: true)
  end
end
