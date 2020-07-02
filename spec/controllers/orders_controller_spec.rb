  require 'rails_helper'


RSpec.describe OrdersController, type: :controller do

 valid_sku = Product.first.sku

  let(:valid_attributes) {
    ({"code": "pedido-1", "data": "2019-09-09T03:00:00", "custumer": "Marcos", "status": "new", "shipping_cost":"10", "items": [{"sku": valid_sku,"qty": 2, "price":100.00}], "total": 210.00 })
  }

  let(:invalid_attributes) {
    ({"code": "pedido-1", "data": "2019-09-09T03:00:00", "custumer": "Marcos", "status": "new", "shipping_cost":"10", "total": 210.00})
  }

  let(:invalid_status) {
    ({"status": "CAN"})
  }


  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :show, params: {id: order.code}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
          post :create, params: {order: valid_attributes}, session: valid_session
          expect(response).to be_successful
      end

      it "renders a JSON response with the new order" do

        post :create, params: {order: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(order_url(Order.last))
      end
    end


context "with invalid params" do
  it "renders a JSON response with errors for the new order" do

    post :create, params: {order: invalid_attributes}, session: valid_session
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.content_type).to eq('application/json')
  end
end
end

describe "PUT #update" do
  context "with valid params" do
    let(:new_attributes) {({'status': 'new'})
  }

  it "updates the requested order" do
    order = Order.create! valid_attributes
    put :update, params: {id: order.code, order: new_attributes}, session: valid_session
    expect(response).to be_successful
  end

  it "renders a JSON response with the order" do
    order = Order.create! valid_attributes

    put :update, params: {id: order.code, order: valid_attributes}, session: valid_session
    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json')
  end
end

context "with invalid params" do
  it "renders a JSON response with errors for the order" do
    order = Order.create! valid_attributes

    put :update, params: {id: order.code, order: invalid_status}, session: valid_session
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.content_type).to eq('application/json')
  end
end
end

describe "DELETE #destroy" do
  it "destroys the requested order" do
    order = Order.create! valid_attributes
    expect {
      delete :destroy, params: {id: order.code}, session: valid_session
      }.to change(Order, :count).by(-1)
    end
  end

end
