class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]


  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show

     if @order.blank?
      render json:{message: 'Pedido não Encontrado!'}, status: :not_found
    else
      render json: @order
    end
  end

  # POST /orders
  def create

    order_params_create[:code].nil? ? new_order = params['order'] : new_order = order_params_create

    new_order[:items].blank? ? ordem_sku = nil : ordem_sku = new_order[:items][0]['sku']

    if ordem_sku.nil? || Product.where(sku: new_order[:items][0]['sku']).blank?
       render  json:{message: 'SKU Não Cadastrado!'}, status: :unprocessable_entity
     elsif
      params.permit!
      @order = Order.new(new_order)
        if @order.save
            render json: @order, status: :created, location: @order
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end
  end

  # PATCH/PUT /orders/1
  def update

    array_items = Order.find_by('code': params['id']).items


    if order_params == {} || valid_status(order_params['status']) == false
       render json:{message: "Apenas o Status do pedido Pode Ser Atualizado com um dos Status! ['new', 'approved', 'shiped', 'delivered', 'canceled']"}, status: :unprocessable_entity


     elsif valid_status(order_params['status']) == true
        @order.update(order_params)
          if params['status'] == 'canceled'
             stock_increment(array_items)
          end
         render json: @order

    else
       render json: @order.errors, status: :unprocessable_entity
    end
  end




  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find_by(code: params[:id]).to_a[0]
    end

    # Only allow a trusted parameter "white list" through.
    def order_params_create

      array_items = []
      items = {}
      params_h = {}
      unless params['items'].blank?
        params['items'].each do |elem|
          items['sku'] = elem['sku']
          items['qty'] = elem['qty']
          items['price'] = elem['price']
          array_items << items
         end
       end

       stock_decrease(array_items)

       params_h[:code] = params[:code]
       params_h[:data] = params[:data]
       params_h[:custumer] = params[:custumer]
       params_h[:status] = params[:status]
       params_h[:shipping_cost] = params[:shipping_cost]
       params_h[:items] = array_items
       params_h[:total] = params[:total]



       params_h

    end


    def order_params
        params.require(:order).permit(:code,:data,:custumer,:status,:shipping_cost,:total,:items)
        #params.require(:order).permit(:status)
    end



  def stock_decrease(array_items)
      array_items.each do |item|
      item_qty = Product.find_by(sku: item['sku'])['qty']
      Product.update({sku: item['sku'], qty: item_qty - item['qty'] })
    end
  end


  def stock_increment(array_items)
    array_items.each do |item|
    item_qty = Product.find_by(sku: item['sku'])['qty']
   Product.update({sku: item['sku'], qty: item_qty + item['qty'] })
    end
  end

  def valid_status params_status
     valid_statuses = ['new', 'approved', 'shiped', 'delivered', 'canceled']
     status = valid_statuses.include? params_status
     status
  end


end
