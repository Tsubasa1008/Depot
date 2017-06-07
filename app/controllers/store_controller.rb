class StoreController < ApplicationController
  include CurrentCount
  before_action :set_count, :show_count_message, only: [:index]
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize
  
  def index
    @products = Product.order(:title)
  end
end
