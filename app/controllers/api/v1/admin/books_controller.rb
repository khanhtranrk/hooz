# frozen_string_literal: true

class Api::V1::Admin::BooksController < ApplicationController
  before_action :set_book, except: %i[index create show]

  def index
    books = Book.filter(params)
                .with_attached_image

    paginate books,
             each_serializer: Admin::BooksSerializer,
             base_url: request.base_url
  end

  def show
    book = Book.includes(:categories, :chapters)
               .find(params[:id])

    expose book,
           serializer: Admin::BookSerializer,
           current_user: @current_user,
           base_url: request.base_url
  end

  def create
    Book.create!(book_params)

    expose
  end

  def update
    @book.update!(book_params)

    expose
  end

  def destroy
    @book.destroy!

    expose
  end

  def upload_image
    @book.update!(upload_image_params)

    expose
  end

  def active
    @book.update!(active_params)

    expose
  end

  private

  def upload_image_params
    params.permit :image
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def active_params
    params.require(:book)
          .permit :active
  end

  def book_params
    params.require(:book)
          .permit :name,
                  :other_names,
                  :author,
                  :description,
                  :active,
                  :free,
                  category_ids: []
  end
end
