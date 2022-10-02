class Admin::HomesController < ApplicationController
  def top  #注文履歴一覧（adminのtop）
    @orders = Order.page(params[:page])
  end
end
