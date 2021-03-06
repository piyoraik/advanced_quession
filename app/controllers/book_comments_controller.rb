# frozen_string_literal: true

class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[create destroy]

  def create
    book_comment = current_user.book_comments.new(book_comment_params)
    book_comment.book_id = @book.id
    book_comment.save!
  end

  def destroy
    book_comment = current_user.book_comments.find_by(book_id: @book.id)
    book_comment.destroy!
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
