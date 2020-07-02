require 'rails_helper'


RSpec.describe ReportsController, type: :controller do




  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {:inicio => '2019-09-08',:fim => '2019-09-10'}, session: valid_session
      #debugger
      expect(response).to be_successful
    end
  end

  describe "GET #index" do
    it "renders a JSON response with errors" do
      get :index, params: {}, session: valid_session
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end



end
