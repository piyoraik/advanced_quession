class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_books, only: [:index, :create]
	before_action :set_book, only: [:show, :edit ,:destroy, :update]
	before_action :set_newbook, only: [:index]
	before_action :edit_auth, only: [:edit, :update, :destroy]

	def index
	end

	def show
	end

	def edit
	end

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
	def set_books
		@books = Book.all
	end

	def set_book
		@book = Book.find(params[:id])
	end

	def set_newbook
		@book = Book.new
	end

	def book_params
		params.require(:book).permit(:title, :body)
	end

	def edit_auth
		book = Book.find(params[:id])
		unless current_user.id == book.user.id
			redirect_to book_path(params[:id])
		end
	end
end
