class LineItemsController < ApplicationController
  include CurrentCart
  include CurrentCount
  before_action :set_cart, only: [:create, :destroy, :increase, :decrease]
  after_action :init_count, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :increase, :decrease]
  before_action :set_price, only: [:increase, :decrease]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_line_item

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url }
        format.js   { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      notice = "已移除品項 " + @line_item.product.title + " 。"
      format.html { redirect_to @line_item.cart, notice: notice }
      format.js   { @current_item = @line_item }
      format.json { head :no_content }
    end
  end

  # increase quantity
  def increase
    @line_item.increase_quantity

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.js   { @current_item = @line_item }
      end
    end
  end

  # decrease quantity
  def decrease
    @line_item.decrease_quantity

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.js   { @current_item = @line_item }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

    # 存取不存在的 line_item
    def invalid_line_item
      logger.error "Attempt to access invalid line_item #{params[:id]}"
      redirect_to store_index_url, notice: 'Invalid line_item'
    end

    def set_price
      @line_item.check_price
    end
end
