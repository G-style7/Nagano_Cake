class Admin::HomesController < ApplicationController
  def top  #注文履歴一覧（adminのtop）
    @orders = Order.all
  end
end
