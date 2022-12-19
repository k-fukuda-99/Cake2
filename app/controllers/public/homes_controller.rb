class Public::HomesController < ApplicationController

  def top
    # admin/genreから持ってくる
    @genres = Genre.all
    # 商品一覧から持ってくる
    @items = Item.all
    #データをランダムに取得する
    @random = Item.order("RANDOM()").limit(4)
  end

  def about
  end
end
