class StoreController < ApplicationController
  include CurrentCount
  before_action :set_count, :show_count_message, only: [:index]
  def index
    @products = Product.order(:title)
  end
end
