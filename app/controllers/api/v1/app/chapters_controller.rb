# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  def show
    chapter = Chapter.find(params[:id])

    raise Errors::PermissionDenied, t(:permission_denied) if !chapter.book.free && @current_user.current_plan.nil?

    reading_chapter = ReadingChapter.find_by(user_id: @current_user.id, book_id: chapter.book_id)

    if reading_chapter
      reading_chapter.update!(chapter_id: chapter.id)
    else
      ReadingChapter.create!(user_id: @current_user.id, book_id: chapter.book_id, chapter_id: chapter.id)
      chapter.book.update!(views: chapter.book.views + 1)
    end

    expose chapter,
           serializer: App::ChapterSerializer,
           base_url: request.base_url
  end
end
