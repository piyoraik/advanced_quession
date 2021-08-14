# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    @book = Book.new
    @search_word = params[:w]
    @books = Book.search(@search_word)
  end
end
