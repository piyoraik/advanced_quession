# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit destroy update]
  before_action :edit_auth, only: %i[edit update destroy]

  def index
    @book = Book.new
    @books = Book.all.includes(:user)
  end

  def show
    @book_comment  = BookComment.new
    @book_comments = @book.book_comments
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books = Book.all.includes(:user)
      render :index
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_path
    else
      render :show
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def edit_auth
    redirect_to book_path(@book.id) unless current_user.id == @book.user.id
  end
end
