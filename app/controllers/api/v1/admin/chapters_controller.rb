# frozen_string_literal: true

class Api::V1::Admin::ChaptersController < ApplicationController
  before_action :set_book
  before_action :set_chapter, except: %i[index create]

  def index
    chapters = Chapter.where(book_id: @book.id)

    paginate chapters,
             each_serializer: Admin::ChaptersSerializer,
             base_url: request.base_url
  end

  def show
    expose @chapter,
           serializer: Admin::ChapterSerializer,
           base_url: request.base_url
  end

  def create
    Chapter.create!(chapter_params.merge(book_id: @book.id))

    expose
  end

  def update
    @chapter.update!(chapter_params)

    expose
  end

  def destroy
    @chapter.destroy!

    expose
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def chapter_params
    params.require(:chapter)
          .permit :name,
                  :content
  end
end
