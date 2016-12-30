require 'my_logger'
class OrdersController < ApplicationController
  skip_before_action :require_admin, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.order_sum = @order.drink.price
    if @order.drink.amount_left < 1
      return redirect_to root_path, notice: t('notice.out_of_drink')
    end
    @order.ingredients.each do |ingredient|
      @order.order_sum += ingredient.price
      if ingredient.amount_left < 1
        return redirect_to root_path, notice: t('notice.out_of_ingredient')
      end
    end
    if @order.user.money_left < @order.order_sum
      return redirect_to root_path, notice: t('notice.no_sufficient_funds')
    end

    respond_to do |format|
      if @order.save
        MyLogger.log(@order.user.name + ': ' + @order.order_sum.to_s)
        @order.user.order(@order.order_sum)
        @order.drink.order
        @order.ingredients.each do |ingredient|
          ingredient.order
        end

        format.html { redirect_to @order, notice: (t('activerecord.models.order')+ ' ' + t('notice.on_create')) }
        format.json { render :show, status: :created, location: @order }
      else
        puts @order.errors.full_messages
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: (t('activerecord.models.order')+ ' ' + t('notice.on_update')) }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: (t('activerecord.models.order')+ ' ' + t('notice.on_destroy')) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_sum, :user_id, :drink_id, :ingredient_ids => [])
    end
end
