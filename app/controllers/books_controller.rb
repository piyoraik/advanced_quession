class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :set_books, only: [:index]

	def index
	end

	private
	def set_books
		@books = Book.all
	end
end
