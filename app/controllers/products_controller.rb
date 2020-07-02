class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
      if params['limit'].nil?
        @products = Product.all
       else
        page = params['page'] .to_i * params['limit'].to_i
       @products = Product.limit(params['limit']).skip(page)
       end
    render json: @products
  end

  # GET /products/1
  def show
       if @product != nil
        render json: @product
       else
         render status: :not_found
      end
  end

  # POST /products
  def create
    if product_params['sku'].nil?
       render json:{message: 'Verifique o Json enviado, o SKU é Obrigatório!'}, status: :unprocessable_entity
    else
      @product = Product.new(product_params)
         if @product.save
            render json: @product, status: :created, location: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
    end
  end

  # PATCH/PUT /products/1
  def update
    #debugger
      if @product.update(product_params)
           render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
          @product = Product.where(sku: params[:id]).to_a[0]
          #@product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:sku, :name, :description, :price, :promotional_price, :qty)
    end
end
