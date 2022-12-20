class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @items_all = Item.all
    if params[:genre_id].present?
       @genre = Genre.find(params[:genre_id])
       @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
     @genres = Genre.all
     if params[:genre_id].present?
       @genre = Genre.find(params[:genre_id])
       @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
     end
  end

  def search
    @items = Item.page(params[:page]).per(10)
    @word_for_search = Genre.find(params[:word_for_search])
    @search_items = Item.where(genre: params[:word_for_search])
  end

end
