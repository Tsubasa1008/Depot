class StoreController < ApplicationController
  include CurrentCount
  before_action :set_count, :show_count_message, only: [:index]
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize
  
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
      @locale = params[:locale]
    else
      @products = Product.order(:title)
    end
  end
end
