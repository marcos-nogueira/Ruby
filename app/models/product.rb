class Product
  include Mongoid::Document
  field :sku, type: String
  field :name, type: String
  field :description, type: String
  field :price, type: Float
  field :promotional_price, type: Float
  field :qty, type: Integer

  attr_readonly :sku






end
