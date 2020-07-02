class Item
  include Mongoid::Document
  field :sku, type: String
  field :qty, type: Integer
  field :price, type: Float
  embedded_in :order




end
