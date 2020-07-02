require 'rails_helper'

describe ProductsController, type: :controller do

  describe 'Consultando Produtos' do

    describe 'Deveria retornar os produtos Corretamente' do

          before {get :index}
        it 'Deveria retornar todos os produtos no GET index' do
          expected_response = Product.count
          json_response = JSON.parse(response.body)
          expect(json_response.count).to eq(expected_response)
          expect(response).to be_success
        end
    end
 end

      describe 'Pesquisando por SKU' do
        sku = Product.first.sku
        before {get :show, params: {id: sku}}
        it 'Deveria retornar o SKU correto' do
        json_response = JSON.parse(response.body)
        expect(json_response["sku"]).to eq(sku)
       end
      end


      describe 'Teste Paginação' do
        limit = 10
        page = 10
        expected_response = Product.limit(limit).skip(page).to_a
        before {get :index, params:{:limit => "10"}}
        it 'Deveria retornar quantidade de produtos e pagina correta' do
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq(expected_response.count)
        end
      end


      describe 'Busca por Sku inexistente' do
        sku_incorreto = '99www'
        before {get :show, params: {id: sku_incorreto}}
        it 'Deveria retornar 404 not_found' do
          expect(response.status).to eq(404)
        end
      end

      describe 'PUT de Estoque de produtos ' do
        sku = Product.first.sku
        qtd = Product.first.qty
        qtd_test = qtd + 10
        let(:product_json) {{"qty" => qtd_test}}
        before {put :update, params:{id: sku, product: product_json}}
        it 'Deveria retornar sucesso' do
           expect(response).to be_success
          end
       end

       describe 'DELETE de Produtos' do
        sku = Product.first.sku
        before {delete :destroy, params:{id: sku}}
        it 'Deveria retornar 204' do
          expect(response.status).to eq(204)
        end
      end

      describe 'POST de Criação de Produtos' do
        let(:product_json) {JSON.parse(File.read('spec/fixtures/product_response.json'))}

        before {post :create, params:{product: product_json}}

        it 'Deveria retornar sucesso' do
          expect(response.status).to eq(201)
          product_created = Product.find_by(sku: '123')
          expect(product_created).not_to be_nil
        end
      end

      describe 'POST de Criação de Produtos Sem SKU' do
        let(:product_json) {JSON.parse(File.read('spec/fixtures/product_without_sku.json'))}

        before {post :create, params:{product: product_json}}

        it 'Deveria retornar 422 e mensagem de erro' do
          json_response = JSON.parse(response.body)
          expect(response.status).to eq(422)
          expect(json_response['message']). to eq('Verifique o Json enviado, o SKU é Obrigatório!')
        end
      end



end